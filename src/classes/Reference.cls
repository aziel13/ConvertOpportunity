public with sharing class Reference {
	// class to hold reference variables and lists
	
	
	// list of sobjects that are transferable in the transfer class.
	private list<string> transferableSObjects;
	public list<string> getTransferableSObjects () {

		return transferableSObjects;
	}
	
	// map of sobjects that are transferable in the transfer class.
	private map<string,string> transferableLabelToName;
	public map<string, string> getTransferableLabelToName () {
		
		if (transferableLabelToName == null) {
			transferableLabelToName = new map<string,string>( );
			transferableLabelToName.put('Attachments', 'Attachment');
			transferableLabelToName.put('Notes', 'Note');
			transferableLabelToName.put('Tasks', 'Task');
			transferableLabelToName.put('Events', 'Event');
		}
		
		
		
		return transferableLabelToName;
		
	}
	
	// map of sobjects that are transferable to the association field used to lookup the opportunity
	private map<string,string> transferableLabelToLookup;
	public map<string,string> getTransferableLabelToLookup () {
	
		if (transferableLabelToLookup == null) {
			transferableLabelToLookup = new map<string,string>( );
			transferableLabelToLookup.put('Attachments', 'ParentId');
			transferableLabelToLookup.put('Notes', 'ParentId');
			transferableLabelToLookup.put('Tasks', 'Whatid');
			transferableLabelToLookup.put('Events', 'Whatid');
		}
		
		return transferableLabelToLookup;
		
	}
	
}