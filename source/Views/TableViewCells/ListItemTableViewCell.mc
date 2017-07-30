using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

const BOX_SIDE_LENGTH = 45; 

class ListItemTableViewCell extends TableViewCell {

	function initialize(label, sublabel, y, height) {
		TableViewCell.initialize(
								 label,
								 sublabel,
								 y,
								 height
								);
    }

    function drawCell(dc, separatorStyle) {
    	TableViewCell.drawCell(dc, separatorStyle); 
 		drawCheckBox(dc); 
    }

    function drawLabels(dc) {
    	dc.setColor(labelColor, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(
    				55,
    				y,
    				Gfx.FONT_LARGE,
    				label,
    				Gfx.TEXT_JUSTIFY_LEFT
    			   );
    	dc.setColor(sublabelColor, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(
    				55,
    				y + height - 30,
    				Gfx.FONT_MEDIUM,
    				sublabel,
    				Gfx.TEXT_JUSTIFY_LEFT
    			   );
    }

    function drawCheckBox(dc) {
    	dc.drawRectangle(
    					 5,
    					 y + 8,
    					 $.BOX_SIDE_LENGTH,
    					 $.BOX_SIDE_LENGTH
    					);
    }
}
