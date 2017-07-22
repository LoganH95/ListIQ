using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Test;

class ListManager {
	const MAX_CACHED_LISTS = 4;
	hidden var lists;
	hidden var numCachedLists;
	
	//Initialization
	
	function initialize() {
         lists = new [0];
         retrieveCachedLists();
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
	
	//Cached lists
    
    function addCachedList(list) {
    	if (numCachedLists >= MAX_CACHED_LISTS) {
    		return;
    	}
    	numCachedLists++;
    	cacheList( numCachedLists, list );
    }
    
    function cacheList(index, list) {
    	if (index > MAX_CACHED_LISTS) {
    		//logger.warning("Cannot save more then four lists");
    		return;
    	}
    	App.AppBase.setProperty("listID_" + index, list.getID() );
    	App.AppBase.setProperty("listTitle_" + index, list.getTitle() );
    }
    
    function retrieveCachedLists() {
    	for ( numCachedLists = 0; numCachedLists < MAX_CACHED_LISTS; numCachedLists++) {
    		var index = numCachedLists + 1;
    		var listID = App.AppBase.getProperty("listID_" + index);
    		if (listID == null) {
    			return;
    		}
    		
    		var list = new List(App.AppBase.getProperty("listTitle_" + index), listID);
    		lists.add(list);
    	}
    	
    }
}