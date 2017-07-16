
class LayoutView extends IQView {
	hidden var layout;

    //Initialization
    
    function initialize(delegate, layout) {
        IQView.initialize( delegate );
        self.layout = layout;
    }
    
    //View Life Cycle

    function onLayout(dc) {
        setLayout( layout( dc ) );
    }

}