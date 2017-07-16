using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class IQView extends Ui.View {
	hidden var delegate, viewLoaded;
	
	function initialize(delegate) {
		View.initialize(); 
		if ( delegate != null ) {
			self.delegate = delegate.weak(); 
		}
		viewLoaded = false;
    }
    
    function onShow() {
    	if ( delegate != null ) {
    		if ( viewLoaded == false ) {
    			viewLoaded = true;
    			getDelegate().viewDidLoad();
    		}
    	
    		getDelegate().viewDidAppear();
    	}
    }
    
    function onUpdate(dc) {
    	View.onUpdate( dc );
    	dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
    	if ( delegate != null ) {
    		getDelegate().viewWillUpdate(dc);
    	}
        dc.drawText( 5, 0, Gfx.FONT_MEDIUM, getTitle(), Gfx.TEXT_JUSTIFY_LEFT );
    }
    
    function onHide() {
    	if ( delegate != null ) {
    		getDelegate().viewDidDisappear();
    	}
    }
    
    function getDelegate() {
    	return delegate.get(); 
    }
    
    function getTitle() {
    	if ( delegate == null ) {
    		return "";
    	} 
    	return getDelegate().getTitle();
    }
}