using Toybox.Graphics as Gfx;

class TextView extends IQView {
	hidden var textArray; 
	
	//Initialization

	function initialize(delegate, text) {
		IQView.initialize(delegate); 
		splitTextIntoArray(text); 
    }
    
    //View Life Cycle
    
    function onUpdate(dc) {
    	IQView.onUpdate(dc);
    	for ( var i = 0; i < textArray.getSize(); i++ ) {
    		dc.drawText( 5, 25 + 15 * i, Gfx.FONT_SMALL, textArray.getItemAtIndex(i), Gfx.TEXT_JUSTIFY_LEFT ); 
    	}
    }
    
    //Private functions
    
    hidden function splitTextIntoArray(text) {
    	var words = splitTextIntoWords(text);
    	textArray = new [0];  
    	var currentLine = ""; 
    	for ( var i = 0; i < words.size(); i++ ) {
    		if (currentLine.length() + words[i].length() > 35) {
    			textArray.add( currentLine ); 
    			currentLine = words[i] + " ";
    		} else {
    			currentLine += words[i] + " ";
    		}
    	}
    	
    	if ( currentLine.length() > 0 ) {
    		textArray.add(currentLine); 
    	}
    }
    
    hidden function splitTextIntoWords(text) {
    	var currentString = ""; 
    	var stringArray = new [0]; 
    	for ( var i = 0; i < text.length(); i++ ) {
    		var char = text.substring(i, i+1); 
    		if ( char.equals(" ") ) {
    			stringArray.add( currentString );
    			currentString = ""; 
    		} else {
    			currentString += char; 
    		}
    	}
    	
    	if ( currentString.length() > 0 ) {
    		stringArray.add( currentString ); 
    	}
    	
    	return stringArray; 
    }
}