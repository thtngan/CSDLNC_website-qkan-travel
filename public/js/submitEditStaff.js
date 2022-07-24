// $(document).ready(function () $("#submitBtn").click(function() {  
//     console.log($("#form" ).serialize());
//     console.log("Done");
//   });


$(document).ready(function(){
    $("#btnSubmit").click(function(event){
        event.preventDefault();
        // alert("Clicked!")
        // console.log($(".form-control").value());
        var a= {
            "id":$("#id").val(),
            "name":$("#name").val(),
            "idNumber":$("#id-number").val(),
            "managerId":$("#manager-id").val(),
            "gender":$('#gender').find(":selected").val(),
            "type":$('#type').find(":selected").val(),
            "dob":$("#dob").val(),
            "address":$("#address").val(),
            "tele":$("#tele").val(),
            "email":$("#email").val()
        };
        console.log(a)
        $.ajax({
            type: "POST",
            url: "../editstaff",
            data: a,
            success: function(){
                window.location.href = "../all-staff"
            }
        });
        
    })
  });