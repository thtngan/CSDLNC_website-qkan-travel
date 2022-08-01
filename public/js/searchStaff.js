$(document).ready(function(){
    $("#btnSubmit").click(function(event){
        event.preventDefault();
        // alert("Clicked!")
        // console.log($(".form-control").value());
        var a= {
            "name":$("#name").val(),
        };
        console.log(a)
        var url = './search/' + $("#name").val();
        window.location.href= url;
        // $.ajax({
        //     type: "POST",
        //     url: "../editstaff",
        //     data: a,
        //     success: function(){
        //         window.location.href = "../all-staff"
        //     }
        // });
        
    })
  });