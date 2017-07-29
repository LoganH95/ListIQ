using Toybox.WatchUi as Ui;
using Toybox.Test as Test;

class ListMenuDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;
	
	function initialize(delegate) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
    	var delegate = getDelegate();
    	switch ( item ) {
    		case :fetch_list_items_menu_item:
    			if ( delegate != null ) {
    				delegate.fetchListItems();
    			}
    			break;
    		case :cache_list_menu_item:
    			if ( delegate != null ) {
    				delegate.cacheList();
    			}
    			break;
    		case :remove_cached_list_menu_item:
    			if ( delegate != null ) {
    				delegate.removeCachedList();
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
