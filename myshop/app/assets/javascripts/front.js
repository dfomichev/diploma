

    var listProducts = function(obj) {
      var cid=$(obj).attr('id')        
      if ( $(obj).attr('class')=='cc'){
      $.ajax({
                           type: "GET",
                            url: "/front/"+cid+"/children",
                            success: function(data){
                                $("#cContainer").empty().html(data);
                                $('div#pDetails').hide();
                            }
                        });
      }
      $.ajax({
                           type: "GET",
                            url: "/front/"+cid+"/products",
                            success: function(data){
                                $("#pContainer").empty().html(data);
                            }
                        });
        return false;

     };
   var showProduct = function(obj) {
      var cid=$(obj).attr('id')        
      $.ajax({
                           type: "GET",
                            url: "/front/"+cid+"/show",
                            success: function(data){
                                $("div#pDetails").empty().html(data);
                               $('div#pDetails').show();
                            }
                        });
            return false;

     };
