$.fx.speeds._default = 1000;

$(function() {

        var $dashboard_facts = $( "#dashboard_facts" ),
            $dashboard_report = $( "#dashboard_report" ),
            $modal_inbounds = $("#load_facts_modal #inbound");
            $modal_facts = $("#load_facts_modal #data_warehouse");

        $( "#load_facts_modal" ).dialog({
            width: 1000,
            modal: true,
            autoOpen: false,
            show: "blind",
            hide: "explode",
            buttons: {
                "Save": function() {
                    $.ajax({
                      type: "POST",
                      url: "data_warehouse/load.json",
                      data: $("#data_warehouse_load").serialize(),
                      success: function( data ) {
                        alert(data);
                        $( "#load_facts_modal" ).dialog( "close" );
                      },
                      error: function( xhr, msg, status ) {
                        var responseText = jQuery.parseJSON(xhr.responseText);
                        alert(responseText + ' Status: ' + status + ' ' + msg);
                        $( "#load_facts_modal" ).dialog( "close" );
                      }
                    });

                    resetDataLoadForm();
                },
                "Cancel": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

        $( ".dashboard_list" )
            .accordion({
                header: "> div > h3"
            })
            .sortable({
                axis: "y",
                handle: "h3",
                stop: function( event, ui ) {
                    // IE doesn't register the blur when sorting
                    // so trigger focusout handlers to remove .ui-state-focus
                    ui.item.children( "h3" ).triggerHandler( "focusout" );
                }
            });

        $( "#opener" )
            .button()
            .click(function( event ) {
                event.preventDefault();
                $( "#load_facts_modal" ).dialog( "open" );

                var $modal = $("#load_facts_modal");

                $("#inbound h3", $modal).html($(".ui-accordion-header-active").parent().find('.inbound_title').html());
                $("#inbound table", $modal).html($(".ui-accordion-header-active").parent().find('.inbound_table').html());

                $("#data_warehouse h3", $modal).html($(".ui-accordion-header-active").parent().find('.data_warehouse_title').html());
                $("#data_warehouse table thead", $modal).html($(".ui-accordion-header-active").parent().find('.data_warehouse_table thead').html());

                $( "td", $modal_inbounds ).draggable({
                  helper: "clone",
                  cursor: "move"
                });

                $("th", $modal_facts).droppable({
                    accept: "#load_facts_modal #inbound table td",
                    drop: function( event, ui ) {
                        loadFact( ui.draggable, $(this) );
                    }
                });

                return false;
            });

        $( "th", $dashboard_facts ).draggable({
            helper: "clone",
            cursor: "move"
        });


        $dashboard_report.droppable({
            accept: "#dashboard_facts table th",
            drop: function( event, ui ) {
                loadReport( ui.draggable );
            }
        });


        function resetDataLoadForm() {
          $("#data_warehouse_load input[name=load_data\\[\\]]").each( function() {
            $(this).remove();
          });

          $("#data_warehouse_load input[name=load_header\\[\\]]").each( function() {
            $(this).remove();
          });

		  $("#data_warehouse_load input[name=load_type\\[\\]]").each( function() {
            $(this).remove();
          });
        }

        function loadReport( $item ) {
          $("#report #body table thead tr", $dashboard_report).append("<th>"+$item.clone().html()+"</th>");

        }

        function loadFact( $item, $column ) {
          var $index = $item.index() + 1;
          var $table = $item.parent().parent();
          var $index_to = $column.index() + 1;
          var $table_to = $column.parent().parent();
          var $headers = $column.parent().find('th');
          var $row_count = $table_to.find('tr').length;
          var $cont = 1;
          var $hidden_data = '<input name="load_data[]" type="hidden"';
          var $hidden_header = '<input name="load_header[]" type="hidden"';
		  var $hidden_type = '<input name="load_type[]" type="hidden"';

          $("#data_warehouse_load #fact").val($('#data_warehouse').find('h3').text());

          $table.find('td:nth-child('+$index+')').each( function(){
            var $content = $(this).html();
			var $type = $(this).attr('type');

            if ($row_count < 2) {
              $table_to.append('<tr></tr>');

              var $last_row = $table_to.find('tr:last');

              $headers.each( function() {
                $last_row.append('<td></td>');
              });

              $last_row.find('td:nth-child('+$index_to+')').append($content);
            } else {
              $table_to.find('tr').eq($cont).find('td:nth-child('+$index_to+')').html($content);
            }


            $("#data_warehouse_load").append($hidden_data + 'id="load_data_' + $cont + '_' + $index_to +'" value="' + $content + '"></input>');

            $("#data_warehouse_load").append($hidden_header + 'id="load_header_' + $cont + '_' + $index_to +'" value="' + $column.text() + '"></input>');

			$("#data_warehouse_load").append($hidden_type + 'id="load_type_' + $cont + '_' + $index_to +'" value="' + $type + '"></input>');

            $cont++;
          });
        }
    });
