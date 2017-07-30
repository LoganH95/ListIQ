using Toybox.Communications as Comm;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class LoginController {

    hidden var delegate;

    function initialize(delegate) {
        self.delegate = delegate;
        Comm.registerForOAuthMessages(method(:accessCodeResult));
    }

    function accessCodeResult(value) {
        if( value.data != null ) {
            getAccessToken(value.data["value"]);
        } else {
            delegate.handleError(value.responseCode);
        }
    }

    function getAccessToken(accessCode) {
        Comm.makeWebRequest(
				            "https://www.wunderlist.com/oauth/access_token",
				            {
				            	"client_id"=>$.CLIENT_ID,
				                "client_secret"=>$.CLIENT_SECRET,
				                "code"=>accessCode
				            },
				            {
				                :method => Comm.HTTP_REQUEST_METHOD_POST
				            },
				            method(:handleAccessResponse)
        				   );
    }

    function handleAccessResponse(responseCode, data) {
        if( data != null ) {
            delegate.handleResponse(data);
        } else {
            delegate.handleError(responseCode);
        }
    }

    function go() {
        Comm.makeOAuthRequest(
				              "https://www.wunderlist.com/oauth/authorize",
				              {
				              	"client_id"=>$.CLIENT_ID,
				                "redirect_uri"=>$.REDIRECT_URL,
				                "state"=>"Random"
				              },
				              $.REDIRECT_URL,
				              Comm.OAUTH_RESULT_TYPE_URL,
				              {"code"=>"value"}
            				 );
    }
}

class LoginControllerDelegate {

    function handleError(code) {
        var msg = "Error: ";
        msg += code;
        var viewController = new ErrorViewController(msg);
        Ui.switchToView(
        				viewController.getView(),
        				viewController,
        				Ui.SLIDE_IMMEDIATE
        			   );
    }

    function handleResponse(data) {
        App.getApp().setProperty("wunderlist_id", data["access_token"]);

        var viewController = new ListManagerTableViewController();
        Ui.switchToView(
        				viewController.getView(),
        				viewController,
        				Ui.SLIDE_IMMEDIATE
        			   );
    }
}
