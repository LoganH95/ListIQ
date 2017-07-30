using Toybox.WatchUi as Ui;

class LoginDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
}

class LoginView extends Ui.View {

    hidden var loginController;
    hidden var running;

    function initialize() {
        View.initialize();
        loginController = new LoginController( new LoginControllerDelegate() );
        running = false;
    }

    function onLayout(dc) {
        setLayout( Rez.Layouts.LoginLayout(dc) );
    }

    function onShow() {
        if ( running == false ) {
            loginController.go();
            running = true;
        }
    }
}
