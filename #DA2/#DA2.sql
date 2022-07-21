USE AdventureWorks2019

----------------------------------------------------------------------------------
--2. Viết các truy vấn sau:
--2a. Cho danh sách các sản phẩm (mã, tên, giá) được mua từ ngày X đến ngày Y
SELECT p2.ProductID, p2.Name, sod.UnitPrice
FROM Sales.SalesOrderDetail sod 
	LEFT JOIN Production.Product p2 ON sod.ProductID = p2.ProductID 
	JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID 
WHERE soh.OrderDate  BETWEEN '7/20/2012' AND '7/20/2022'
drop index index_soh_orderdate on Sales.SalesOrderHeader
create nonclustered index index_soh_orderdate on Sales.SalesOrderHeader (OrderDate asc) 
sp_helpindex 'Sales.SalesOrderHeader'
--2b. Cho danh sách các saleperson làm việc/bán hàng online trong tháng 7/2011.
SELECT e.*
FROM Sales.SalesPerson sp 
	RIGHT JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID 
	LEFT JOIN HumanResources.Employee e ON e.BusinessEntityID = sp.BusinessEntityID 
WHERE soh.OrderDate BETWEEN '20110701' AND '20110731'
SELECT e.*
FROM Sales.SalesPerson sp 
	RIGHT JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID 
	LEFT JOIN HumanResources.Employee e ON e.BusinessEntityID = sp.BusinessEntityID 
WHERE MONTH(soh.OrderDate) = 7 AND YEAR(soh.OrderDate) = 2011

--2c. Nâng cao: cho danh sách các thành phần cấu thành “bicycles” (gợi ý: SQL Server Recursive CTE)
WITH cte_BOM (ProductID, Name, Color, Quantity, ProductLevel, ProductAssemblyID, Sort)
AS  (SELECT P.ProductID,
            CAST (P.Name AS VARCHAR (100)),
            P.Color,
            CAST (1 AS DECIMAL (8, 2)),
            1,
            NULL,
            CAST (P.Name AS VARCHAR (100))
     FROM   Production.Product AS P
            INNER JOIN
            Production.BillOfMaterials AS BOM
            ON BOM.ComponentID = P.ProductID
            AND BOM.ProductAssemblyID IS NULL
            AND (BOM.EndDate IS NULL
                OR BOM.EndDate > GETDATE())
     UNION ALL
     SELECT P.ProductID,
            CAST (REPLICATE('|---', cte_BOM.ProductLevel) + P.Name AS VARCHAR (100)),
            P.Color,
            BOM.PerAssemblyQty,
            cte_BOM.ProductLevel + 1,
            cte_BOM.ProductID,
            CAST (cte_BOM.Sort + '\' + p.Name AS VARCHAR (100))
     FROM   cte_BOM
            INNER JOIN Production.BillOfMaterials AS BOM
            ON BOM.ProductAssemblyID = cte_BOM.ProductID
            INNER JOIN Production.Product AS P
            ON BOM.ComponentID = P.ProductID
            AND (BOM.EndDate IS NULL
                OR BOM.EndDate > GETDATE())
    )
SELECT   ProductID,
         Name,
         Color,
         Quantity,
         ProductLevel,
         ProductAssemblyID,
         Sort
FROM     cte_BOM
ORDER BY Sort;

----------------------------------------------------------------------------------
-- 3. Viết function:
--3a. Cho biết standardCost của 1 sản phẩm cho trước được đặt vào 1 ngày cụ thể.
CREATE FUNCTION [dbo].[ufnGetProductStandardCost](@ProductID [int], @OrderDate [datetime])
RETURNS [money] 
AS 
-- Returns the standard cost for the product on a specific date.
BEGIN
    DECLARE @StandardCost money;

    SELECT @StandardCost = pch.[StandardCost] 
    FROM [Production].[Product] p 
        INNER JOIN [Production].[ProductCostHistory] pch 
        ON p.[ProductID] = pch.[ProductID] 
            AND p.[ProductID] = @ProductID 
            AND @OrderDate BETWEEN pch.[StartDate] AND COALESCE(pch.[EndDate], CONVERT(datetime, '99991231', 112)); -- Make sure we get all the prices!

    RETURN @StandardCost;
END;

select [dbo].[ufnGetProductStandardCost](707, '5/20/2012 00:00:00') standardCost

--3b. Cho biết số lượng trong kho tại 1 locationID cho trước của 1 sản phẩm cụ thể.
CREATE FUNCTION [dbo].[ufnGetStockAtLocation](@ProductID [int], @LocationID [int])
RETURNS [int] 
AS 
-- Returns the stock level for the product. This function is used internally only
BEGIN
    DECLARE @ret int;
    
    SELECT @ret = SUM(p.[Quantity]) 
    FROM [Production].[ProductInventory] p 
    WHERE p.[ProductID] = @ProductID 
        AND p.[LocationID] = @LocationID; -- Only look at inventory in the misc storage
    
    IF (@ret IS NULL) 
        SET @ret = 0
    
    RETURN @ret
END;
