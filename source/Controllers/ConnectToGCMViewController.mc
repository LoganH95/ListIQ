using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class ConnectToGCMViewController extends LayoutViewController {

	//Initialization
	
	function initialize(layout) {
		LayoutViewController.initialize(layout);
	}
	
	//Delegate Methods
	
	function onSelect() {
		if ( System.getDeviceSettings().phoneConnected ) {
            var wunderListId = App.getApp().getProperty( "wunderlist_id" );
            
            if ( wunderListId == null ) {
            	Ui.switchToView(new LoginView(), new LoginDelegate(), Ui.SLIDE_IMMEDIATE);
	        } else {
	        	var viewController = new ListManagerTableViewController(); 
	        	Ui.switchToView(viewController.getView(), viewController, Ui.SLIDE_IMMEDIATE);
	        }
        } 
	}
}