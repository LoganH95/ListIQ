using Toybox.WatchUi as Ui;

class ListTableViewController extends TableViewController {
	hidden var list, communicationController; 
	
	//Initialization
	
	function initialize(list, communicationController) {
		TableViewController.initialize();
		self.list = list;
		title = list.getTitle(); 
		tableView.setSeparatorStyle( TableViewSeparatorStyleTitle );
		self.communicationController = communicationController;
		communicationController.registerDelegate( self );
		fetchData();
	}
	
	hidden function fetchData() {
		communicationController.retrieveTasksByID( list.getID() );
	}
	
	//WunderlistCommunicationController Delegate Methods
	
	function didRecieveLists(lists) {
    	//Do Nothing
    }
    
    function didRecieveTasks(tasks, listID) {
    	if ( listID != list.getID() ) {
			return;    	
    	}
    	
    	list.addTasks(tasks);
    	reloadView();
    }
    
    function didRecieveError(errorCode) {
    	var errorViewController = new ErrorViewController( errorCode );
    	Ui.pushView( errorViewController.getView(), errorViewController, Ui.SLIDE_UP);
    }
	
	//Datasource Methods
	
	function numberOfRowsInTableView() {
		return list.getSize(); 
	}
	
	function cellAtIndex(index) {
		var task = list.getTaskAtIndex( index ); 
		var position = index - tableView.position; 
		var height = heightForRow(); 
		var y = startPosition + ( height * position ); 
		var listCell = new ListItemTableViewCell( task.title, task.dueDate, y, height ); 
		return listCell;
	}
	
	//Delegate Methods
	
	function didSelectRowAtIndex(index, coord) {
		var height = heightForRow();
		var y = coord[1] - (startPosition + (height * index));
		var x = coord[0]; 
		if ( x < BOX_SIDE_LENGTH ) {
			communicationController.completeTask(list.getTaskAtIndex(index));
			list.removeTaskAtIndex(index); 
			reloadView();
		}
	}
	
	//Behavior Delegate
    
    function onMenu() {
        Ui.pushView(new Rez.Menus.list_menu(), new ListMenuDelegate(self), Ui.SLIDE_UP); 
    	return true;
    }
    
    
    //List Menu Delegate
    
    function cacheList() {
    	var parentViewController = self.getParentViewController();
    	if (parentViewController != null) {
    		parentViewController.cacheList(list);
    	}
    }
}
