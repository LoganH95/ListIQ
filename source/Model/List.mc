
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
    	self.sortTasks();
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

	//Sorting

	function sortTasks() {
		quicksort( 0, tasks.size() );
	}

	hidden function quicksort( left, right ) {
		if (right - left <= 1 ) {
			return;
		}

		var partition = partition( left, right );

		quicksort( left, partition);
		quicksort( partition + 1, right );
	}

	hidden function partition( low, high ) {
		var pivot;
		var help;
		var left = low;
		var right = high - 1;
		pivot = tasks[right];

		while ( right > left ) {
			if ( compareStrings( pivot.dueDate, tasks[right - 1].dueDate ) ) {
				tasks[right] = tasks[right - 1];
				right--;
			} else {
				help = tasks[right - 1];
				tasks[right - 1] = tasks[left];
				tasks[left] = help;
				left++;
			}
		}
		tasks[right] = pivot;

		return right;
	}

	hidden function compareStrings( string1, string2 ) {
		var charArray1 = string1.toCharArray();
		var charArray2 = string2.toCharArray();
		for ( var i = 0; i < charArray1.size() && i < charArray2.size(); i++ ) {
			if ( charArray1[i] < charArray2[i] ) {
				return true;
			} else if ( charArray2[i] < charArray1[i] ) {
				return false;
			}
		}

		return charArray1.size() > charArray2.size();
	}
}
