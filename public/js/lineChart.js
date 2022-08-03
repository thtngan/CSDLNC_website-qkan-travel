// $(document).ready(function () $("#submitBtn").click(function() {  
//     console.log($("#form" ).serialize());
//     console.log("Done");
//   });


$(document).ready(function(){
        // alert("Clicked!")
        // console.log($(".form-control").value());
        console.log("Done")
        $.ajax({
            type: "GET",
            url: "admin/getRevenue",
            success: function(res){
                console.log(res.lineChart)
                var xValues = res.lineChart.yearList;
                var yValues = res.lineChart.revenuList;
                new Chart("myChart", {
                    type: "line",
                    data: {
                       labels: xValues,
                       datasets: [{
                          label: "$ (dollar)",
                          fill: false,
                          lineTension: 0,
                          backgroundColor: "rgba(0,0,255,1.0)",
                          borderColor: "rgba(39, 145, 245, 1)",
                          data: yValues
                       }]
                    }
                    });
            }
        });
        
    });

                 