function rand(length,current){
 current = current ? current : '';
 return length ? rand( --length , "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz".charAt( Math.floor( Math.random() * 60 ) ) + current ) : current;
}


$(document).ready(function() {
     $('.tab-content:first').show(2);
    $('.tab:first>span').addClass('selected');
    $('.tab>span').click(function(){
       $('.tab>span').removeClass('selected');
       $(this).addClass('selected'); 
       $('.tab-content').hide(0);   
       $(this).next('.tab-content').show(0);     
    }); 
    $(function () {

        $("#tree").click(function () {
          if ( $("#tree").jstree("get_selected").attr("blocked" )){
                $("#delNode").attr('disabled', 'disabled');
          }else{
                $("#delNode").removeAttr('disabled');
          }
        });

        $("#addCNode").click(function () {
                $("#tree").jstree("create",null,false,{ attr: { _cid : rand(16),is_new: "true" }, data: "Some other child node" });
        });

        $("#addPNode").click(function () {
                $("#tree").jstree("create",-1,"first",{ attr: { _cid : rand(16) ,is_new: "true"}, data: "Some other 1-st level node" });
        });

        $("#renNode").click(function () {
                $("#tree").jstree("rename");
        });

        $("#delNode").click(function () {
           $("#tree").jstree("get_selected").hide();
           $("#tree").jstree("get_selected").attr("is_deleted","true");
        });

        $("#saveTree").click(function () {
                _json=$("#tree").jstree("get_json",-1,["is_deleted","_cid","is_new"]);
                $.post( "/categories/save",{ json : _json}).done(function( data ) {
                            $("#json").append(data);
                });

        });
	$("#tree").jstree({
		"json_data" : {
			"ajax" : {"url" : "/categories/json"}
		},
                "dnd" : {
                        "drop_finish" : function () {
                        },
                        "drag_check" : function (data) {
                                if(data.r.attr("id") == "phtml_1") {
                                        return false;
                                }
                                return {
                                        after : false,
                                        before : false,
                                        inside : true
                                };
                        },
                        "drag_finish" : function (data) {
                        }
                },
                "ui" : {
                        "select_limit" : 1
                },
                "plugins" : [ "themes", "ui", "crrm","dnd","json_data" ]
        }).bind("select_node.jstree", function (NODE, REF_NODE) {
            var a = $.jstree._focused().get_selected();
	});

    });
});

