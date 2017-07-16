//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//
using Toybox.Communications as Comm;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class LoginController
{
    hidden var _delegate;
    hidden var _complete;

    // Constructor
    function initialize(delegate) {
        _delegate = delegate;
        _complete = false;
        // Register a callback to handle a response from the
        // OAUTH request. If there is a response waiting this
        // will fire right away
        Comm.registerForOAuthMessages(method(:accessCodeResult));
    }

    // Handle converting the authorization code to the access token
    // @param value Content of JSON response
    function accessCodeResult(value) {
    	//Sys.print(value);
        if( value.data != null) {
            _complete = true;
            // Extract the access code from the JSON response
            getAccessToken(value.data["value"]);
        }
        else {
            Sys.println("Error in accessCodeResult");
            Sys.println("data = " + value.data);
            _delegate.handleError(value.responseCode);
        }
    }

    // Convert the authorization code to the access token
    function getAccessToken(accessCode) {
        // Make HTTPS POST request to request the access token
        Comm.makeWebRequest(
            // URL
            "https://www.wunderlist.com/oauth/access_token",
            // Post parameters
            {
            	"client_id"=>$.ClientId,
                "client_secret"=>$.ClientSecret,
                "code"=>accessCode
            },
            // Options to the request
            {
                :method => Comm.HTTP_REQUEST_METHOD_POST
            },
            // Callback to handle response
            method(:handleAccessResponse)
        );
    }


    // Callback to handle receiving the access code
    function handleAccessResponse(responseCode, data) {
        // If we got data back then we were successful. Otherwise
        // pass the error onto the delegate
        if( data != null) {
            _delegate.handleResponse(data);
        } else {
            Sys.println("Error in handleAccessResponse");
            Sys.println("data = " + data);
            _delegate.handleError(responseCode);
        }
    }

    // Method to kick off tranaction
    function go() {
        // Kick of a request for the user's credentials. This will
        // cause a notification from Connect Mobile to file
        Comm.makeOAuthRequest(
            // URL for the authorization URL
            "https://www.wunderlist.com/oauth/authorize",
            // POST parameters
            {
                "client_id"=>$.ClientId,
                "redirect_uri"=>$.RedirectUri,
                "state"=>"Random"
            },
            // Redirect URL
            $.RedirectUri,
            // Response type
            Comm.OAUTH_RESULT_TYPE_URL,
            // Value to look for
            {"code"=>"value"}
            );
    }
}

class LoginControllerDelegate {

    // Constructor
    function initialize() {
    	//Do Nothing
    }

    // Handle a error from the server
    function handleError(code) {
        var msg = WatchUi.loadResource( Rez.Strings.error );
        msg += code;
        var viewController = new ErrorViewController(msg);
        Ui.switchToView(viewController.getView(), viewController, Ui.SLIDE_IMMEDIATE);
    }

    // Handle a successful response from the server
    function handleResponse(data) {
        App.getApp().setProperty("wunderlist_id", data["access_token"]);
        
        var viewController = new ListManagerTableViewController(); 
        Ui.switchToView(viewController.getView(), viewController, Ui.SLIDE_IMMEDIATE);
    }

}