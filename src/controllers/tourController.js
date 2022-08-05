const bcrypt = require('bcryptjs');
const sequelize = require('sequelize');
const db = require('../../_helper/db');
const Tour = db.Tour;
const City = db.City;
const Country = db.Country;

module.exports = {
    getAllTours,
    getTourById,
    getAllCity,
    searchTour,
    searchTransport,
    searchHotel,
    bookTour
    // getById,
    // create,
    // update,
    // delete: _delete
};

async function getAllTours() {
    const tours = await db.sequelize.query(
        "SELECT t.*, c1.city_name as destination_city, c2.city_name as departure_city FROM TOUR t FULL OUTER JOIN CITY c1 ON c1.id = t.destination_id FULL OUTER JOIN CITY c2 ON c2.id = t.departure_id",
        {
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));

    // console.log(JSON.stringify(tours));

    return tours;
}

async function getTourById(Tid) {
    const tours = await db.sequelize.query(
        "SELECT t.*, c1.city_name as destination_city, c2.city_name as departure_city FROM TOUR t FULL OUTER JOIN CITY c1 ON c1.id = t.destination_id FULL OUTER JOIN CITY c2 ON c2.id = t.departure_id Where t.id= ?",
        {
            replacements: [Tid],
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));

    // console.log(JSON.stringify(tours));

    return tours;
}

async function getAllCity() {
    const city = await db.sequelize.query(
        "SELECT city_name,id FROM CITY",
        {
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));

    // console.log(JSON.stringify(city));
    return city;
}

async function searchTour(depart, arrival, startDate) {
    const tours = await db.sequelize.query(
        "SELECT t.*, c1.city_name as destination_city, c2.city_name as departure_city FROM TOUR t FULL OUTER JOIN CITY c1 ON c1.id = t.destination_id FULL OUTER JOIN CITY c2 ON c2.id = t.departure_id"
        + " Where destination_id = ? AND departure_id = ? AND depart_date = ?",
        {
            replacements: [arrival, depart, startDate],
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));

    return tours;
}


async function searchTransport(departID) {
    const tours = await db.sequelize.query(
        "select se.id as id, ty.ticket_type_name as name from TRANSPORT_SERVICE se left join TICKET_TYPE ty"
        + " on se.ticket_type_id = ty.id where se.from_city_id = ?",
        {
            replacements: [departID],
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));
    return tours;
}

async function searchHotel() {
    const tours = await db.sequelize.query(
        "select se.id as id, ty.room_type_name as name from HOTEL_SERVICE se left join ROOM_TYPE ty"
        + " on se.room_type_id = ty.id",
        {
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));
    return tours;
}

async function bookTour(info) {
    // console.log(info.customerID)
    // const custom_id = db.sequelize.define("custom_id", {
    //     custom_id: {
    //         type: db.sequelize.DataTypes.INTEGER,
    //         allowNull: false
    //     }
    //  });
     custom_id = parseInt(info.customerID)
    const res = await db.sequelize
    // .query('CALL sp_order_add (:cust_id, :tour_id, :quantity, :note, :payment_method, :hotel_service_id, :transport_service_id, :tour_price)', 
    //       {
    //         replacements: { cust_id: parseInt(info.customerID), tour_id: info.tourID, quantity: info.quantity, note: info.note, 
    //             payment_method: info.payment, hotel_service_id: info.hotel, transport_service_id: info.transport, tour_price: info.price}
    //     })
    .query('EXEC sp_order_add @cust_id=?, @tour_id=?, @quantity=?, @note=?, @payment_method=?, @hotel_service_id=?, @transport_service_id=?, @tour_price=?', 
          {
            replacements: [ parseInt(info.customerID), parseInt(info.tourID), parseInt(info.quantity), "abc", 
                info.payment, parseInt(info.hotel), parseInt(info.transport), parseFloat(info.price)],
            type:sequelize.QueryTypes.RAW
        })
    .catch((error) => console.error(error));
    return res;
}