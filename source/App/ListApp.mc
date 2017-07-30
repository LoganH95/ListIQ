using Toybox.Application as App;
using Toybox.System as Sys;

class ListApp extends App.AppBase {
	
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        var wunderListId = App.getApp().getProperty( "wunderlist_id" );
		
        if ( !System.getDeviceSettings().phoneConnected ) {
        	var controller = new ConnectToGCMViewController(Rez.Layouts.Gcm);
        	return [ controller.getView(), controller ];
        } else if ( wunderListId == null ) {
            return [ new LoginView(), new LoginDelegate() ];
        } else {
        	var  viewController = new ListManagerTableViewController(); 
            return [ viewController.getView(), viewController ];
        }
    }

}
