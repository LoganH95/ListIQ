
class Task {
	var title, id, dueDate, revision; 

	//Initialization

	function initialize(title, id, dueDate, revision) {
         self.title = title; 
         self.id = id;
         self.dueDate = dueDate ? dueDate : ""; 
         self.revision = revision;
    }
}