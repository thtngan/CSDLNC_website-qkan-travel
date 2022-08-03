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
            url: "admin/getIncoming",
            success: function(res){
                console.log(res.barChart.nameList)
                var ctx = document.getElementById("myChart1").getContext('2d');
                var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: res.barChart.nameList,
                    datasets: [{
                    label: 'incoming',
                    data: res.barChart.incomeList,
                    backgroundColor: "rgba(153,255,51,1)"
                    }, {
                    label: 'spending',
                    data: res.barChart.spendList,
                    backgroundColor: "rgba(255,153,0,1)"
                    }]
                },
                options: {
                    indexAxis: 'y',
                  }
                });
            }
        });
        
    });

                 