using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class ListMenuDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;
	
	function initialize(delegate) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
    	switch (item) {
    		case :saveList:
    			var delegate = getDelegate();
    			if (delegate != null) {
    				delegate.cacheList();
    			}
    			break;
    	}
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
    
    function notifyDelegateSettingsDidChange() {
    	getDelegate().settingsDidChange();
    }
}

class OnOffConfirmationDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;

     function initialize(delegate, property) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
        self.property = property;
    }

    function onMenuItem(item) {
        App.getApp().setProperty("reps", item == :On);
        getDelegate().notifyDelegateSettingsDidChange();
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
}

class RestConfirmationDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;

    function initialize(delegate) {
    	MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
        App.getApp().setProperty("rest", item == :On);
        if (item == :On) {
        	 Ui.pushView(new TimePicker(), new RestPickerDelegate(getDelegate()), Ui.SLIDE_IMMEDIATE); 
        }
        getDelegate().notifyDelegateSettingsDidChange();
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
}