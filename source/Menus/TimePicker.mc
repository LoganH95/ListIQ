using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

const FACTORY_COUNT_24_HOUR = 3;
const FACTORY_COUNT_12_HOUR = 4;
const MINUTE_FORMAT = "%02d";

class TimePicker extends Ui.Picker {

    function initialize() {
        var title = new Ui.Text({:text=>"Set Time", :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var factories = new [2];
        var hourFactory;
        var numberFactories;

     	factories[0] = new NumberFactory(0, 59, 1, null);
        factories[1] = new NumberFactory(0, 59, 5, {:format=>MINUTE_FORMAT});
        Picker.initialize({:title=>title, :pattern=>factories});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class TimePickerDelegate extends Ui.PickerDelegate {

	hidden var delegate;

	function initialize(delegate) {
		PickerDelegate.initialize();
		self.delegate = delegate.weak();
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var seconds = (values[0] * 60) + values[1]; 
        App.getApp().setProperty("sec", seconds);
		getDelegate().notifyDelegateSettingsDidChange();
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
    
    function getDelegate() {
    	return delegate.get();
    }
}

class RestPickerDelegate extends Ui.PickerDelegate {

	hidden var delegate;

	function initialize(delegate) {
		PickerDelegate.initialize();
		self.delegate = delegate.weak();
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var rest = (values[0] * 60) + values[1]; 
        App.getApp().setProperty("restTime", rest);
        getDelegate().notifyDelegateSettingsDidChange();
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
    
    function getDelegate() {
    	return delegate.get();
    }
}
