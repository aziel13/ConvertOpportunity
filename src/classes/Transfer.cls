public with sharing class Transfer {

	// class to transfer notes, attachments, tasks, and events from an opportunity to a lead.
	private boolean firstRun{ get{if(firstRun == null) {firstRun = true;} return firstRun; } set;}
	// error msg holder
	private string errorMsg;
	public string getErrorMsg () {
		// make sure that the error msg is never null.
		if (errorMsg == null) {
			errorMsg = '';
		}
		
		return errorMsg;
	}
	
	private boolean opportunityError;
	public boolean getOpportunityError () {
		if (opportunityError == null) {
			opportunityError = false;
			// insure thet the opportunity is initialized
			getSourceOpportunity();
		}
		return opportunityError;
	}
	
	
    // the message output to the user to explain how this page is used
    private string functionDescription;
    public string getFunctionDescription () {
        if (functionDescription == null)
        	functionDescription = 'Transfer attachments, notes, tasks, and events from converted opportunity to the new lead.';
        
        return functionDescription;
    }
    
    // source opportunity to transfer from
    private Opportunity sourceOpportunity;
    public Opportunity getSourceOpportunity() {
    	
    	// find the opportunity passed through its id if one exists
        string oppId = Apexpages.currentPage().getParameters().get('oppId');
        if (sourceOpportunity == null && !String.isblank(oppId) && firstRun) {
        	sourceOpportunity = [SELECT id, name, ConvertedLeadId__c  FROM Opportunity WHERE id =: oppId];
        	
        	// post an error message if an opportunity was not provided instead of allowing the user to attempt a transfer
        	if (sourceOpportunity == null) {
        		opportunityError = true;
        		errorMsg = 'An opportunity to transfer from has not been provided. Please go back to the opportunity and make use of the transfer button.';
        	}
        	
        	firstRun = false;
        }
        
    	return sourceOpportunity;
    }
    
    // boolean to determine if the attachments will be transfered
    private boolean transferAllAttachments;
    public boolean getTransferAllAttachments() {
    	
    	// check if an opportunity is provied to the page
    	string oppId = Apexpages.currentPage().getParameters().get('oppId');
    	
    	// initialize to true if the lead id is valued
    	if(transferAllAttachments == null )
    		transferAllAttachments = (targetLead == null) ? false : true;

    	return transferAllAttachments;
    }
    public void setTransferAllAttachments(boolean value) {
    	transferAllEvents = value;
    }
    
    // boolean to determine if the notes will be transfered
    private boolean transferAllNotes;
    public boolean getTransferAllNotes() {	
    	
    	// check if an opportunity is provied to the page
    	string oppId = Apexpages.currentPage().getParameters().get('oppId');
    	
    	// initialize to true if the lead id is valued
    	if(transferAllNotes == null )
    		transferAllNotes = (targetLead == null) ? false : true;
    	
    	return transferAllNotes;
    }
    public void setTransferAllNotes(boolean value) {
    	transferAllEvents = value;
    }
    
    // boolean to determine if the tasks will be transfered
    private boolean transferAllTasks;
    public boolean getTransferAllTasks() {	
    	
    	// check if an opportunity is provied to the page
    	string oppId = Apexpages.currentPage().getParameters().get('oppId');
    	
    	// initialize to true if the lead id is valued
    	if(transferAllTasks == null )
    		transferAllTasks = (targetLead == null) ? false : true;
    	
    	return transferAllTasks;
    }
    public void setTransferAllTasks(boolean value) {
    	transferAllEvents = value;
    }
    
    // boolean to determine if the events will be transfered
    private boolean transferAllEvents;
    public boolean getTransferAllEvents() {	
    	
    	// check if an opportunity is provied to the page
    	string oppId = Apexpages.currentPage().getParameters().get('oppId');
    	
    	// initialize to true if the lead id is valued
    	if(transferAllEvents == null )
    		transferAllEvents = (targetLead == null) ? false : true;
    	
    	return transferAllEvents;
    }
    public void setTransferAllEvents(boolean value) {
    	transferAllEvents = value;
    }
    
    
    // target lead to transfer to
    private Lead targetLead;
    public Lead getTargetLead () {
    	
    	return targetLead;
    }
    
    private integer totalRecordsToTransfer;
    public integer getTotalRecordsToTransfer() {
    	
    	if (sourceOpportunity != null && totalRecordsToTransfer == null)
    		totalRecordsToTransfer = totolRecordsToTransfer(sourceOpportunity.id);
    	
    	return totalRecordsToTransfer;
    }
    
    
    // method that handles the transfer of requested notes, attachments, tasks, and events from the opportunity to lead
    public void transfer() {
    	// before trying to do any transfer determine if the number of records to be transfered will break the limits.
    	if(sourceOpportunity != null && isWithinLimits(sourceOpportunity.id)) {
    		
    		// transfer attachments
    		if (transferAllAttachments) {
    			
    		}
    		// transfer notes
    		if (transferAllNotes) {
    		
    		}
    		// transfer tasks
    		if (transferAllTasks) {
    		
    		}
    		// transfer events
    		if (transferAllEvents) {
    		
    		}
    		
    	} else {
    		// the limits for number of records that can be updated will be broken. Display an error message
    		
    	}
    }
    
    // method to determine the total number of records to transfer
    public integer totolRecordsToTransfer( string oppId  ) {
    	
    	// cumlative number of records to be queried
    	integer recordsQueried = 0;
    	
    	// if attachments are to be transfered count how many within 10,001
    	if (transferAllAttachments)
    		recordsQueried += [Select Count() From Attachment Where ParentId = :oppId And IsDeleted=false Limit 10001];
    	
    	// if notes are to be transfered count how many within 10,001
    	if (transferAllNotes)
    		recordsQueried += [Select Count() From Note Where ParentId = :oppId And IsDeleted=false Limit 10001];
    		
    	// if tasks are to be transfered count how many within 10,001
    	if (transferAllTasks)
    		recordsQueried += [Select Count() From Task Where Whatid = :oppId And IsDeleted=false Limit 10001];
    		
    	// if events are to be transfered count how many within 10,001
    	if (transferAllEvents)
    		recordsQueried += [Select Count() From Event Where Whatid = :oppId And IsDeleted=false Limit 10001];
    	
    	return recordsQueried;
    }
    
    // method that handles checking if the number of records will exceed the total number of queries or updates that this can do at one time
    public boolean isWithinLimits( string oppId ) {
    	// result of the limit checking opperation. Assume that it will pass
    	boolean limitResult = true;
    	
    	if(totolRecordsToTransfer(oppId) > 10000) 
    		limitResult = false;

    	return limitResult;
    	
    }
    
     // method to handle the behavior of the cancel button
    public PageReference cancel() {
        PageReference returnRef;
        String oppId = Apexpages.currentPage().getParameters().get('oppId');
        // if an opportunity was defined use the id to return to the opportunity page
        if(!String.isblank(oppId) ) 
            returnRef = new PageReference('/' + oppId);
        else 
        // if you cannot find the appropriate opportunity 
           returnRef = new PageReference('/');
        
        return returnRef;
    }
    
    

}