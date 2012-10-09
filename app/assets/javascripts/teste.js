$(function() {
        var $dashboard_facts = $( "#dashboard_facts" ),
            $dashboard_report = $( "#dashboard_report" );
 
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
 
        function loadReport( $item ) {
			$("td", $dashboard_report).text($item.clone().html());
        }
    });