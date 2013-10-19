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
                                $("#editContainer").html(data);
                            }
                        });

            return false;

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
                $("#tree").jstree("create",null,false,{ attr: { id : rand(16),is_new: "true" }, data: "Some other child node" });
        });

        $("#addPNode").click(function () {
                $("#tree").jstree("create",-1,"first",{ attr: { id : rand(16) ,is_new: "true"}, data: "Some other 1-st level node" });
        });

        $("#renNode").click(function () {
                $("#tree").jstree("rename");
        });

        $("#delNode").click(function () {
           $("#tree").jstree("get_selected").hide();
           $("#tree").jstree("get_selected").attr("is_deleted","true");
           $("#tree").jstree('select_node',$("#tree").find('li')[0]);
        });

        $("#saveTree").click(function () {
                _json=$("#tree").jstree("get_json",-1,["is_deleted","id","is_new"]);
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
                "checkbox" :{
                    "two_state": true,
                    "real_checkboxes": true,
                    "real_checkboxes_names": function (n) { return [ ("cat["+ n[0].id )+"]",n[0].id ]}
                },
                "plugins" : [ "themes", "ui", "crrm","dnd","json_data","checkbox" ]
        }).bind("select_node.jstree", function (NODE, REF_NODE) {
            var a = $.jstree._focused().get_selected();
    	});

    });
    $("#tree").bind("loaded.jstree", function (event, data) {
        if (typeof  check_list !=='undefined') {
            $.each( check_list, function( key,value ) {
               $("#tree").jstree('check_node','#'+value); 
            });
        }else{
            $("#tree").jstree('hide_checkboxes');
            $("#tree").jstree('select_node',$("#tree").find('li')[0]);
        }
     })

});

