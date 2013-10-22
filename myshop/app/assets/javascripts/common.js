function rand(length,current){
 current = current ? current : '';
 return length ? rand( --length , "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz".charAt( Math.floor( Math.random() * 60 ) ) + current ) : current;
}


$(document).ready(function() {

    $(document).on('click','#addProdcut', function() {
      $.ajax({
                           type: "GET",
                            url: "/products/edit",
                            success: function(data){
                                $("#editContainer").empty().html(data);
                            }
                        });

            return false;

     });  

    $(document).on('click','.productEdit', function() {
              $.ajax({
                           type: "GET",
                            url: "/products/"+$(this).attr('id')+"/edit",
                            success: function(data){
                                $("#editContainer").empty().html(data);
                            }
                        });

            return false;

    });


  
    $(document).on('click','#addAttr', function() {
       
      $.ajax({
                           type: "GET",
                            url: "/attribute_set/edit",
                            success: function(data){
                                $("#editContainer").empty().html(data);
                            }
                        });

            return false;

     });  

  
});

