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
        	functionDescription = 'Convert your Opportunity back into a lead <br/> This will create a new lead based on your selections';
        
        return functionDescription;
    }
    
    // source opportunity to transfer from
    private Opportunity sourceOpportunity;
    public Opportunity getSourceOpportunity() {
    	
    	// find the opportunity passed through its id if one exists
        string oppId = Apexpages.currentPage().getParameters().get('oppId');
        if (sourceOpportunity == null && !String.isblank(oppId) && firstRun) {
        	sourceOpportunity = [SELECT id,name  FROM Opportunity WHERE id =: oppId];
        	
        	// post an error message if an opportunity was not provided instead of allowing the user to attempt a transfer
        	if (sourceOpportunity == null) {
        		opportunityError = true;
        		errorMsg = 'An opportunity to transfer from has not been provided. Please go back to the opportunity and make use of the transfer button.';
        	}
        	
        	firstRun = false;
        }
        
    	return sourceOpportunity;
    }
    
    // target lead to transfer to
    private Lead targetLead;
    public Lead getTargetLead () {
    
    	return targetLead;
    }
    
    
    

}