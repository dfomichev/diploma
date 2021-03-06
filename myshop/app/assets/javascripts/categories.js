   $("#tree").jstree({
        "json_data" : {
            "ajax" : {"url" : "/categories/json"}
        },
                "default" : { "max_depth"  : 3 },
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
                "plugins" : [ "themes", "ui", "crrm","dnd","json_data" ]
        }).bind("select_node.jstree", function (NODE, REF_NODE) {
            var a = $.jstree._focused().get_selected();
        });
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

