using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Communications as Comm;
using Toybox.System as Sys;
using Toybox.Test as Test;

class WunderlistCommunicationController {

	hidden const validHTTPResponse = 200; 
	hidden var wunderlistID;
	hidden var delegates;

	//Initialization

	function initialize() {
		wunderlistID = App.getApp().getProperty("wunderlist_id");
		delegates = new [0];
    }

    //Delegate Methods

    function registerDelegate(delegate) {
    	if ( delegate != null ) {
    		delegates.add( delegate.weak() );
    	}
    }

    function getDelegateAtIndex(index) {
    	return delegates[index].get();
    }

    function numDelegates() {
    	return delegates.size();
    }

    hidden function alertDelegatesDidRecieveLists(lists) {
    	for ( var i = 0; i < numDelegates(); i++ ) {
    		var delegate = getDelegateAtIndex(i);
    		if ( delegate != null ) {
    			delegate.didRecieveLists(lists);
    		}
    	}
    }

    hidden function alertDelegatesDidRecieveTasks(tasks, listID) {
    	for ( var i = 0; i < numDelegates(); i++ ) {
    		var delegate = getDelegateAtIndex(i);
    		if ( delegate != null ) {
    			delegate.didRecieveTasks(tasks, listID);
    		}
    	}
    }

    hidden function alertDelegatesDidRecieveError(error) {
    	for ( var i = 0; i < numDelegates(); i++ ) {
    		var delegate = getDelegateAtIndex(i);
    		if ( delegate != null ) {
    			delegate.didRecieveError(error);
    		}
    	}
    }

    //Communication Methods

    function retrieveLists() {
    	Comm.makeWebRequest(
				            "https://a.wunderlist.com/api/v1/lists",
				            null,
				            {
				             :method=>Comm.HTTP_REQUEST_METHOD_GET,
				             :headers=>{
								   "X-Access-Token"=>wunderlistID,
								   "X-Client-ID"=>$.CLIENT_ID
							   },
				             :responseType=>Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
				            },
				            method(:retieveListsCallback)
				           );
    }

    function retrieveTasksByID(listID) {
    	Comm.makeWebRequest(
						"https://a.wunderlist.com/api/v1/tasks",
						{
							"list_id"=>listID
						},
						{
				             :method=>Comm.HTTP_REQUEST_METHOD_GET,
				             :headers=>{
							       "X-Access-Token"=>wunderlistID,
								   "X-Client-ID"=>$.CLIENT_ID
							   },
				             :responseType=>Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
				            },
						method(:retieveListTasksCallback)
					   );
    }

    function completeTask(task) {
		var url = "https://a.wunderlist.com/api/v1/tasks/" + task.id;
		var body = {
			    	"revision"=>task.revision,
			    	"completed"=>true
			   	   };
		var options = {
		               :method=>Comm.HTTP_REQUEST_METHOD_PUT,
		               :headers=>{
							"X-Access-Token"=>wunderlistID,
							"X-Client-ID"=>$.CLIENT_ID,
							"Content-Type"=>Comm.REQUEST_CONTENT_TYPE_JSON
					     },
		               :responseType=>Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
				      };
	    var callback = method(:completeTaskCallback);

    	Comm.makeWebRequest(
							url,
							body,
							options,
							callback
					  	   );
    }

    //Call Backs

    function retieveListsCallback(responseCode, data) {
    	if (responseCode != validHTTPResponse || data == null) {
    		Test.assertMessage( false, "WunderlistCommunicationController Error: " + data );
    		alertDelegatesDidRecieveError(responseCode);
    		return;
    	}

    	var lists = createListsFromData(data);
    	alertDelegatesDidRecieveLists(lists);
    }

    function retieveListTasksCallback(responseCode, data) {
    	if ( responseCode != validHTTPResponse || data == null ) {
    		Test.assertMessage( false, "WunderlistCommunicationController Error: " + data );
    		alertDelegatesDidRecieveError(responseCode);
    		return;
    	} else if ( data.size() == 0 ) {
    		alertDelegatesDidRecieveTasks( null, null );
    		return;
    	}

    	var tasks = createTasksFromData( data );
    	alertDelegatesDidRecieveTasks( tasks, data[0].get("list_id") );
    }

    function completeTaskCallback(responseCode, data) {
    	Test.assertMessage( validHTTPResponse == responseCode, "WunderlistCommunicationController Error: " + data );
    }

    //Private Functions

    hidden function createListsFromData(data) {
    	var lists = new [0];
    	for ( var i = 0; i < data.size(); i++ ) {
    		var list = new List(
    							data[i].get("title"),
    							data[i].get("id")
    						   );
    		lists.add( list );
    	}
    	return lists;
    }

    hidden function createTasksFromData(data) {
    	var tasks = new [0];
    	Sys.println(data);
    	for ( var i = 0; i < data.size(); i++ ) {
    		var task = new Task(
    							data[i].get("title"),
    							data[i].get("id"),
    							data[i].get("due_date"),
    							data[i].get("revision")
    						   );
    		tasks.add( task );
    	}
    	return tasks;
    }
}
