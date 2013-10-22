$('ul.tabs').on('click', 'li:not(.current)', function() {
     $(this).addClass('current').siblings().removeClass('current')
           .parents('div.section').find('div.box').eq($(this).index()).show().siblings('div.box').hide();
     var href=$(this).attr('href'); 
     if (typeof href!=="undefined"){
         var box=$(this).parents('div.section').find('div.box').eq($(this).index());
         $.ajax({
                           type: "GET",
                            url: href,
                            success: function(data){
                                $(box).empty().html(data);
                            }
                        });

    }
    return false;
});
          
