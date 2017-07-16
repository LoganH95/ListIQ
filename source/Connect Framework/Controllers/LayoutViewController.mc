using Toybox.WatchUi as Ui;

class LayoutViewController extends ViewController {
	
	//Initialization
	
	function initialize(layout) {
		ViewController.initialize();
		title = ""; 
		view = new LayoutView(self, layout);
	}
}