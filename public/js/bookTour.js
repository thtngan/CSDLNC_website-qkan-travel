$(document).ready(function(){
    $("#submitBtn").click(function(event){
        // alert("Clicked!")
        // console.log($(".form-control").value());
        // var a= {
        //     "name":$("#lblPrice").val(),
        //     "idNumber":$("#numPer").val(),
        //     "managerId":$("#manager-id").val(),
        //     "gender":$('#gender').find(":selected").val(),
        //     "type":$('#type').find(":selected").val(),
        //     "dob":$("#dob").val(),
        //     "address":$("#address").val(),
        //     "tele":$("#tele").val(),
        //     "email":$("#email").val()
        // };
        console.log($("#price").val() * $("#numPer").val())
        $("#noti-price").text("Total price: " + $("#price").val() * $("#numPer").val())
        // $.ajax({
        //     type: "POST",
        //     url: "./addstaff",
        //     data: a,
        //     success: function(){
        //         window.location.href = "./all-staff"
        //     }
        // });
        
    })
  });

  $(document).ready(function(){
    $("#bookTourBtn").click(function(event){
        // alert("Clicked!")
        // console.log($(".form-control").value());
        var a= {
            "customerID":"3",
            "tourID":$("#tourID").val(),
            "quantity":$("#numPer").val(),
            "note":"",
            "payment":$("input[name='payMethod']:checked").val(),
            "transport":$("#transport").find(":selected").val(),
            "hotel":$("#hotel").find(":selected").val(),
            "price":$("#numPer").val()*$("#price").val(),
        };
        console.log(a)
         $.ajax({
            type: "POST",
            url: "/addtour",
            data: a,
            success: function(){
                // window.location.href = "/"
                console.log("Done")
            }
        });
        // console.log($("#price").val() * $("#numPer").val())
        // $("#noti-price").text("Total price: " + $("#price").val() * $("#numPer").val())
        // $.ajax({
        //     type: "POST",
        //     url: "./addstaff",
        //     data: a,
        //     success: function(){
        //         window.location.href = "./all-staff"
        //     }
        // });
        
    })
  });