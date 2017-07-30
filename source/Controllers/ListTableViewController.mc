using Toybox.WatchUi as Ui;

class ListTableViewController extends TableViewController {
	
	hidden var list;
	hidden var communicationController; 

	//Initialization

	function initialize(list, communicationController) {
		TableViewController.initialize();
		self.list = list;
		title = list.getTitle(); 
		tableView.setSeparatorStyle( TableViewSeparatorStyleTitle );
		self.communicationController = communicationController;
		communicationController.registerDelegate( self );
	}

	//View Life Cycle

	function viewDidLoad() {
		if ( list.getSize() == 0 ) {
			fetchListItems();
		}
	}

	//Fetch Data

	function fetchListItems() {
		list.clearTasks();
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
    	Ui.pushView( 
    				errorViewController.getView(), 
    				errorViewController, 
    				Ui.SLIDE_UP 
    			   );
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
		var listCell = new ListItemTableViewCell( 
												 task.title, 
												 task.dueDate, 
												 y, 
												 height 
												); 
		return listCell;
	}

	//Delegate Methods

	function didSelectRowAtIndex(index, coord) {
		var height = heightForRow();
		var y = coord[1] - ( startPosition + ( height * index ) );
		var x = coord[0]; 
		if ( x < $.BOX_SIDE_LENGTH ) {
			communicationController.completeTask(list.getTaskAtIndex(index));
			list.removeTaskAtIndex(index); 
			reloadView();
		}
	}

	//Behavior Delegate

    function onMenu() {
    	var menu = isCachedList() ? new Rez.Menus.list_menu_remove() : new Rez.Menus.list_menu_save();
    	menu.setTitle(list.getTitle() + " Menu");
    	Ui.pushView(
    				menu, 
    				new ListMenuDelegate(self), 
    				Ui.SLIDE_UP
    			   );
    	return true;
    }

    //List Menu Delegate

    function cacheList() {
    	var parentViewController = self.getParentViewController();
    	if ( parentViewController != null ) {
    		parentViewController.cacheList(list);
    	}
    }

    function removeCachedList() {
    	var parentViewController = self.getParentViewController();
    	if ( parentViewController != null ) {
    		parentViewController.removeCachedList(list);
    	}
    }

    function isCachedList() {
    	var parentViewController = self.getParentViewController();
    	if ( parentViewController != null ) {
    		return parentViewController.isCachedList(list);
    	}
    	return false;
    }
}
