$(document).ready(function(){
    $("#submitBtn").click(function(event){
        console.log($("#price").val() * $("#numPer").val())
        $("#noti-price").text("Total price: " + $("#price").val() * $("#numPer").val())      
    })
  });

  $(document).ready(function(){
    $("#bookTourBtn").click(function(event){
        var a= {
            "customerID":"3",
            "tourID":$("#tourID").val(),
            "quantity":$("#numPer").val(),
            "note":$("#comment").val(),
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
                window.location.href = "/"
            }
        });
        
    })
  });