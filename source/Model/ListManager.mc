using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ListManager {
	hidden var lists;
	
	//Initialization
	
	function initialize() {
         lists = new [0];
    }
    
    //Data Methods
    
    function add(list) {
		lists.add( list );
    }
	
	function getListById(id) {
		for ( var i = 0; i < numLists(); i++ ) {
			var list = lists[i]; 
			if ( list.getID() == id ) {
				return list;
			}
		}
		return null;
	}
	
	function addItemToListById(id, item) {
		var list = getListById( id ); 
		if ( list == null ) {
			list.addTask( item );
		}
	}
	
	function getListAtIndex(index) {
		return lists[index];
	}
	
	function numLists() {
		return lists.size();
	}
}