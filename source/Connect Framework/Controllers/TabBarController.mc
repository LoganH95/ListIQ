using Toybox.WatchUi as Ui;
using Toybox.Test as Test;

class TabBarController extends ViewController {
	hidden var controllers, current, position; 

	//Initialization
	
	function initialize() {
		ViewController.initialize();
		controllers = new IQArray(); 
		position = 0; 
    }
    
    //View Life Cycle
    
    function viewWillUpdate(dc) {
		//Subclass can override to provide functionallity
		updateView( Ui.SLIDE_IMMEDIATE );
	}
    
    //Behavior Delegate
    
    function onSwipe(evt) {
    	var transition = null;
    	if ( evt.getDirection() == Ui.SWIPE_LEFT ) {
    		position++; 
    		if ( position == controllers.getSize() ) {
    			position = 0; 
    		}
    		transition = Ui.SLIDE_LEFT;
    	} else if ( evt.getDirection() == Ui.SWIPE_RIGHT ) {
    		position--;
    		if ( position < 0 ) {
    			position = controllers.getSize() - 1; 
    		} 
    		transition = Ui.SLIDE_RIGHT;
    	}
    	updateView( transition );
    	return true; 
    }
    
    //TabBarController Methods
    
    hidden function updateView(transition) {
    	var controller = controllers.getItemAtIndex(position); 
		if ( controller != null ) {
			Ui.switchToView( controller.getView(), controller, transition );
		} else {
			Test.assertMessage(false, "Null View Controller: TabBarController 51");
		}
    }
    
    hidden function addViewController(controller) {
    	controller.setParentViewController(self); 
    	controllers.addItem(controller);
    }
    
    hidden function clearControllers() {
    	controllers = new IQArray();
    	position = 0;
    }
}