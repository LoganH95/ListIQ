using Toybox.WatchUi as Ui;

class ViewController extends Ui.BehaviorDelegate {
	hidden var title, view, parentViewController; 
	
	//Initialization
	
	function initialize() {
		BehaviorDelegate.initialize();
		title = ""; 
		view = new IQView(self);
	}
	
	//View Life Cycle
	
	function reloadView() {
		 Ui.requestUpdate(); 
	}
	
	function viewDidLoad() {
		//Subclass can override to provide functionallity; 
	}
	
	function viewDidAppear() {
		//Subclass can override to provide functionallity; 
	}
	
	function viewWillUpdate(dc) {
		//Subclass can override to provide functionallity; 
	}
	
	function viewDidDisappear() {
		//Subclass can override to provide functionallity; 
	}
	
	function getView() {
		return view; 
	}
	
	function getTitle() {
		return title;
	}
	
	function setParentViewController(parentViewController) {
		self.parentViewController = parentViewController.weak(); 
	}
	
	function getParentViewController() {
		return parentViewController ? parentViewController.get() : null;
	}
	
	//Behavior Delegate
	
	function onKey(evt) {
		var parentViewController = getParentViewController();
		if (parentViewController == null) {
			return; 
		}
		parentViewController.onKey(evt); 
	}
	
	function onMenu() {
		var parentViewController = getParentViewController();
		if (parentViewController == null) {
			return; 
		}
        parentViewController.onMenu();
    }
    
    function onTap(evt) {
		var parentViewController = getParentViewController();
    	if (parentViewController == null) {
			return; 
		}
    	parentViewController.onTap(evt);
    }
	
	function onSwipe(evt) {
		var parentViewController = getParentViewController();
		if (parentViewController == null) {
			return; 
		}
    	parentViewController.onSwipe(evt);
    }
}
