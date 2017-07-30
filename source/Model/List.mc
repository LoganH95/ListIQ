
class List {

	hidden var title;
	hidden var tasks;
	hidden var id;
	hidden var cached;  
	
	//Initialization
	
	function initialize(title, id) {
         self.title = title;
         self.id = id;
         tasks = new [0];
    }
    
    //Data Methods
    
    function getTitle() {
    	return title; 
    }
    
    function getID() {
    	return id;
    }
    
    function getTaskAtIndex(index) {
    	return tasks[index]; 
    }
    
    function addTask(task) {
    	tasks.add( task );
    }
    
    function addTasks(tasks) {
    	self.tasks.addAll( tasks );
    }
    
    function removeTaskAtIndex(index) {
    	tasks.remove( tasks[index] );
	}
	
	function getSize() {
		return tasks.size(); 
	}
	
	function clearTasks() {
		tasks = new [0];
	}
}
