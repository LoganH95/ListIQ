using Toybox.WatchUi as Ui;
using Toybox.Test as Test;

class ListManagerMenuDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;

	function initialize(delegate) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
    	var delegate = getDelegate();
    	switch ( item ) {
    		case :fetch_lists_menu_item:
    			if ( delegate != null ) {
    				Ui.popView(Ui.SLIDE_IMMEDIATE);
    				delegate.fetchLists();
    			}
    			break;
    		case :clear_cached_lists_menu_item:
    			if ( delegate != null ) {
    				Ui.pushView(new Rez.Menus.confirmation_menu(), new ConfirmationDelegate(delegate), Ui.SLIDE_IMMEDIATE);
    			}
    			break;
    		default:
    			Test.assertMessage(false, "Missing menu item case");
    			return;
    	}
    }

    function getDelegate() {
    	return delegate.get();
    }
}

class ConfirmationDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;

    function initialize(delegate) {
    	MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
        if ( item == :yes_menu_item ) {
        	var delegate = getDelegate();
        	if ( delegate != null ) {
				delegate.clearCachedLists();
			}
        }
    }

    function getDelegate() {
    	return delegate.get();
    }
}
