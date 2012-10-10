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
          $table.find('td:nth-child('+$index+')').each( function(){
            $column.parent().parent().append('<tr><td>'+$(this).html()+'</td></tr>');
            console.log($index + ' ' + $table.find('td:nth-child('+$index+')').html());
          });
        }
    });
