
class TableViewController extends ViewController {
	hidden var tableView, screen_size, startPosition; 
	
	//Initialization
	
	function initialize() {
		ViewController.initialize(); 
		tableView = new TableView( self, self ); 
		view = tableView; 
		screen_size = 2; 
		startPosition = 28; 
	}
	
	//TableView Datasource Methods
	
	function heightForRow() {
		return 61; 
	}
	
	function numberOfRowsInTableView() {
		//Subclass Should override this
		return 0; 
	}
	
	function cellAtIndex(index) {
		//Subclass Should override this
		return new TableViewCell(); 
	}
	
	//TableView Delegate Methods
	
	function getTableView() {
		return tableView; 
	}
	
	function didSelectRowAtIndex(index, coord) {
		//Subclass can override this to provide aditional functionality
	}
	
	function scrollTableView() {
		//Subclass Should override this for custom scrolling
		if ( numberOfRowsInTableView() > tableView.position + screen_size ) {
	    	tableView.scrollUp(); 
	    } else {
	    	tableView.resetPosition(); 
	    }
	    reloadView();
	}
	
	//Behavior Delegate
    
    function onKey(evt) {
    	if ( evt.getKey() == 4 ) {
    		scrollTableView(); 
    		return true;
    	}
    	else {
    		return false; 
    	}
    }

    function onMenu() {
        scrollTableView(); 
    	return true;
    }
    
    function onTap(evt) {
    	var y = evt.getCoordinates()[1];
    	var height = heightForRow(); 
    	for ( var i = 0; i < numberOfRowsInTableView(); i++ ) {
    		var startY = startPosition + (height * i);
    		if ( startY <= y && y <= startY + height) {
    			didSelectRowAtIndex(i + tableView.position, evt.getCoordinates());
    		}
    	}
    	return true; 
    }
}