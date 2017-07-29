using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Test as Test;

class ListManager {

	const MAX_CACHED_LISTS = 4;
	hidden var lists;
	hidden var numCachedLists;
	hidden var cachedListIds;
	
	//Initialization
	
	function initialize() {
         lists = new [0];
         cachedListIds = new [MAX_CACHED_LISTS];
         numCachedLists = 0;
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
	
	function clearLists() {
		lists = new [0];
	}
	
	//Cached lists
    
    function isCachedList(list) {
    	return indexOfCachedList(list) != -1;
    }
    
    function cacheList(list) {
    	if ( numCachedLists >= MAX_CACHED_LISTS ) {
    		return;
    	}
    	App.AppBase.setProperty("listID_" + numCachedLists, list.getID() );
    	App.AppBase.setProperty("listTitle_" + numCachedLists, list.getTitle() );
    	addCachedList(list);
    }
    
    function removeCachedList(list) {
    	for ( var index = indexOfCachedList(list); index < numCachedLists - 1; index++ ) {
    		 cachedListIds[index] = cachedListIds[index + 1];
    		 App.AppBase.setProperty("listID_" + index, cachedListIds[index]);
    		 App.AppBase.setProperty("listTitle_" + index,  App.AppBase.getProperty("listTitle_" + (index + 1)));
    	}
    	removeLastList();
    }
    
    function clearCachedLists() {
    	while ( numCachedLists > 0 ) {
    		removeLastList();
    	}
    }
    
    hidden function removeLastList() {
    	numCachedLists--;
    	App.AppBase.setProperty("listID_" + numCachedLists, null );
    	App.AppBase.setProperty("listTitle_" + numCachedLists, null );
    }
    
    hidden function addCachedList(list) {
    	if ( numCachedLists >= MAX_CACHED_LISTS) {
    		Test.assertMessage( false, "ListManager: Max number of cached lists");
    		return;
    	}
    	cachedListIds[numCachedLists] = list.getID();
    	numCachedLists++;
    }
    
    hidden function retrieveCachedLists() {
    	for ( var i = 0; i < MAX_CACHED_LISTS; i++) {
    		var listID = App.AppBase.getProperty("listID_" + i);
    		if ( listID == null ) {
    			return;
    		}
    		var list = new List(App.AppBase.getProperty("listTitle_" + i), listID);
    		lists.add(list);
    		addCachedList(list);
    	}
    }
    
    hidden function indexOfCachedList(list) {
    	for ( var index = 0; index < numCachedLists; index++) {
    		if ( list.getID() == cachedListIds[index] ) {
    			return index;
    		}
    	}
    	return -1;
    }
}
