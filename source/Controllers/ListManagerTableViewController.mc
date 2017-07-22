using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class ListManagerTableViewController extends TableViewController {
	hidden var listManager, communicationController, listControllers; 
	
	//Initialization
	
	function initialize() {
		TableViewController.initialize();
		listManager = new ListManager();
		communicationController = new WunderlistCommunicationController();
		communicationController.registerDelegate(self);
		title = "List IQ";
	}
	
	//View Life Cycle
	
	function viewDidLoad() {
		if (listManager.numLists() == 0) {
			fetchData();
		} else {
			listControllers = new [ listManager.numLists() ];
		}
	}
	
	hidden function fetchData() {
    	var layout = new LayoutView(null, Rez.Layouts.Fetching);
    	Ui.pushView(layout, null, Ui.SLIDE_IMMEDIATE);
    	
    	communicationController.retrieveLists();
	}
	
	//WunderlistCommunicationController Delegate Methods
	
	function didRecieveLists(lists) {
    	for ( var i = 0; i < lists.size(); i++ ) {
			var list = lists[ i ];
			listManager.add( list );
		}
		listControllers = new [ lists.size() ]; 
		reloadView();
		Ui.popView( Ui.SLIDE_IMMEDIATE );
    }
    
    function didRecieveTasks(tasks, listID) {
    	//Do nothing
    }
    
    function didRecieveError(errorCode) {
    	var errorViewController = new ErrorViewController( errorCode );
    	Ui.pushView( errorViewController.getView(), errorViewController, Ui.SLIDE_UP);
    }
	
	//Datasource Methods
	
	function numberOfRowsInTableView() {
		return listManager.numLists(); 
	}
	
	function cellAtIndex(index) {
		var list = listManager.getListAtIndex( index ); 
		var position = index - tableView.position; 
		var height = heightForRow(); 
		var y = startPosition + ( height * position ); 
		var cell = new TableViewCell( list.getTitle(), "", y, height ); 
		return cell; 
	}
	
	//Delegate Methods
	
	function didSelectRowAtIndex(index, coord) {
		var listController = listControllers[ index ];
		if ( listController == null ) {
			listController = new ListTableViewController( listManager.getListAtIndex(index), communicationController );
			listController.setParentViewController(self);
			listControllers[ index ] = listController;
		}
		Ui.pushView( listController.getView(), listController, Ui.SLIDE_LEFT);
	}
	
	//ListManager Menu Delegate
    
    function cacheList(list) {
    	listManager.addCachedList(list);
    }
}