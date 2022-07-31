$(document).ready(function(){
    $("#btnSearch").click(function(event){
        event.preventDefault();
        console.log("Done")
        // alert("Clicked!")
        // console.log($(".form-control").value());
        var a= {
            "depart":$("#depart").val(),
            "arrival":$("#arrival").val(),
            "depart_day":$("#departDate").val()
        };
        var url = './search/' + $("#depart").val() + '/' +$("#arrival").val() + '/'+ $("#departDate").val();
        window.location.href= url;
    })
  });