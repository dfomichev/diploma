  	$("#ptree").jstree({
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
    $("#ptree").bind("loaded.jstree", function (event, data) {
        if (typeof  check_list !=='undefined') {
            $.each( check_list, function( key,value ) {
               $("#ptree").jstree('check_node','#'+value); 
            });
        }
     })

