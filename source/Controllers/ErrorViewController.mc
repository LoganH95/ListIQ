using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ErrorViewController extends ViewController {

	hidden var error;
	
	//Initialization
	
	function initialize(error) {
		ViewController.initialize();
		self.error = error;
	}
	
	//Life Cycle View
	
	function viewWillUpdate(dc) {
		dc.drawText( 
					75, 
					75, 
					Gfx.FONT_LARGE, 
					error + "", 
					Gfx.TEXT_JUSTIFY_CENTER 
				   );
	}
}
