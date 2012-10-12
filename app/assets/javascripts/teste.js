$(function() {
        var $dashboard_facts = $( "#dashboard_facts" ),
            $dashboard_report = $( "#dashboard_report" ),
            $dashboard_inbounds = $("#dashboard_inbounds");

        $( "th", $dashboard_facts ).draggable({
            helper: "clone",
            cursor: "move"
        });

        $( "td", $dashboard_inbounds ).draggable({
          helper: "clone",
          cursor: "move"
        });

        $dashboard_report.droppable({
            accept: "#dashboard_facts table th",
            drop: function( event, ui ) {
                loadReport( ui.draggable );
            }
        });

        $("th", $dashboard_facts).droppable({
            accept: "#dashboard_inbounds table td",
            drop: function( event, ui ) {
                loadFact( ui.draggable, $(this) );
            }
        });

        function loadReport( $item ) {
          $("td", $dashboard_report).text($item.clone().html());
        }

        function loadFact( $item, $column ) {
          var $index = $item.index() + 1;
          var $table = $item.parent().parent();
          var $index_to = $column.index() + 1;
          var $table_to = $column.parent().parent();
          var $headers = $column.parent().find('th');
          var $row_count = $table_to.find('tr').length;
          var $cont = 1;

          $table.find('td:nth-child('+$index+')').each( function(){
            var $content = $(this).html();

            if ($row_count < 2) {
              $table_to.append('<tr></tr>');

              var $last_row = $table_to.find('tr:last');

              $headers.each( function() {
                $last_row.append('<td></td>');
              });

              $last_row.find('td:nth-child('+$index_to+')').append($content);
            } else {
              $table_to.find('tr').eq($cont).find('td:nth-child('+$index_to+')').append($content);
            }

            $cont++;
          });
        }
    });
