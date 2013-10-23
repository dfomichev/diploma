function rand(length,current){
 current = current ? current : '';
 return length ? rand( --length , "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz".charAt( Math.floor( Math.random() * 60 ) ) + current ) : current;
}


$(document).ready(function() {
  
    $(document).on('click','#Save', function() {
       var id=$(this).closest("#editContainer").children('form').attr('pid');
       alert(id);
       return false;  
       if (! form.valid() ){ return false;}
         var _data=$('form#product').serialize();
         $.ajax({
                           type: "POST",
                            data : _data,
                            cache: false,
                            url: "/products/"+id+"/save",
                            success: function(data){
                                $('ul.tabs li.current').trigger( "click" );
                                $("#message").html(data);
                                if (id=='' ){
                                    $('form#product')[0].reset();
                                }
                            }
                        });

            return false;

     });

  
  
    $(document).on('click','#addProdcut', function() {
      $.ajax({
                           type: "GET",
                            url: "/products/edit",
                            success: function(data){
                                $("#Container").empty().html(data);

                            }
                        });

            return false;

     });  

    $(document).on('click','.editProduct', function() {
              $.ajax({
                           type: "GET",
                            url: "/products/"+$(this).attr('id')+"/edit",
                            success: function(data){
                                $("#editContainer").empty().html(data);
                            }
                        });

            return false;

    });

    $(document).on('click','.editAttribute', function() {
              $.ajax({
                           type: "GET",
                            url: "/attributes/"+$(this).attr('id')+"/edit",
                            success: function(data){
                                $("#editContainer").empty().html(data);
                            }
                        });

            return false;

    });


    $(document).on('click','.delProduct', function() {
        var answer = confirm('Are you sure you want to delete this?');
        if (answer)
        {
              $.ajax({
                           type: "GET",
                            url: "/products/"+$(this).attr('id')+"/delete",
                            success: function(data){
                            }
                        });
              $('ul.tabs li.current').trigger( "click" );
        } 
            return false;

    });

    $(document).on('click','.delAttribute', function() {
        var answer = confirm('Are you sure you want to delete this?');
        if (answer)
        {
              $.ajax({
                           type: "GET",
                            url: "/attributes/"+$(this).attr('id')+"/delete",
                            success: function(data){
                                
                            }
                        });
              $('ul.tabs li.current').trigger( "click" );
        }
            return false;

    });
  
    $(document).on('click','#addAttr', function() {
       
      $.ajax({
                           type: "GET",
                            url: "/attributes/edit",
                            success: function(data){
                                $("#editContainer").empty().html(data);

                            }
                        });

            return false;

     });  

    $('ul.tabs li.current').trigger( "click" );  
});

