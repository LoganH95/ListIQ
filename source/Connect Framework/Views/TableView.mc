using Toybox.Graphics as Gfx;

enum { 
	TableViewSeparatorStyleSingle,
	TableViewSeparatorStyleTitle,
	TableViewSeparatorStyleNone
}

class TableView extends IQView {
	hidden var datasource, separatorStyle; 
	var position;

	//Initialization
	
	function initialize(datasource, delegate) {
		IQView.initialize(delegate); 
		self.datasource = datasource.weak(); 
		position = 0; 
		separatorStyle = TableViewSeparatorStyleSingle; 
    }
    
    //View Life Cycle
    
    function onUpdate(dc) {
        IQView.onUpdate(dc);
        for ( var i = position; i < getDatasource().numberOfRowsInTableView(); i++ ) {
    		var cell = getDatasource().cellAtIndex( i ); 
    		cell.drawCell( dc, separator( i ) ); 
    	}
    }
    
    //Public Methods
    
    function setSeparatorStyle(separatorStyle) {
    	self.separatorStyle = separatorStyle; 
    }
    
    function scrollUp() {
    	position++;
    }
    
    function resetPosition() {
    	position = 0; 
    }
    
    //Private Methods
    
    hidden function separator(index) {
    	if ( separatorStyle == TableViewSeparatorStyleSingle ) {
    		return true;
    	} else if ( separatorStyle == TableViewSeparatorStyleTitle && index == position ) {
    		return true;
    	}
    	
    	return false;
    }
    
    hidden function getDatasource() {
    	return datasource.get(); 
    }
}