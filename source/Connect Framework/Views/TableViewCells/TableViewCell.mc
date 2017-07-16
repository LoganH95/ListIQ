using Toybox.Graphics as Gfx;

class TableViewCell {
	hidden var label, sublabel, y, height, labelColor, sublabelColor; 
	
	//Initialization
	
	function initialize(label, sublabel, y, height) {
		self.label = label;
		self.sublabel = sublabel; 
		self.y = y;
		self.height = height; 
		labelColor = Gfx.COLOR_WHITE;
		sublabelColor = Gfx.COLOR_LT_GRAY; 
    }
    
    //View Life Cycle
    
    function drawCell(dc, separator) {
    	if ( separator ) {
    		drawLine(dc);
    	}
    	drawLabels(dc); 
    }
    
    //Private Methods
    
    hidden function drawLine(dc) {
    	dc.drawLine(0, y, dc.getWidth(), y); 
    }
    
    hidden function drawLabels(dc) {
    	dc.drawText(10, y + height/4, Gfx.FONT_LARGE, label, Gfx.TEXT_JUSTIFY_LEFT);
    	dc.drawText(10, y + (3 * height/4), Gfx.FONT_SMALL, sublabel, Gfx.TEXT_JUSTIFY_LEFT);
    }
}