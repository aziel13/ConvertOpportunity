public class Convert {
    // The function of this class is to convert an opportunity into a lead.
    // The first version of this class will only work when there is a prior lead that the opportunity is derived from
	
    private boolean firstRun{ get{if(firstRun == null) {firstRun = true;} return firstRun; } set;}
	
    // the message output to the user to explain how this page is used
    private string functionDescription;
    public string getFunctionDescription () {
        if (functionDescription == null)
        	functionDescription = 'Convert your Opportunity back into a lead <br/> This will create a new lead based on your selections';
        
        return functionDescription;
    }
    
    
    // The opportunity to be converted back into a lead
    private opportunity oppToConvert;
    public Opportunity getOppToConvert() {
        
		// find the opportunity passed through its id if one exists
        string oppId = Apexpages.currentPage().getParameters().get('oppId');
        
        // if the opportunity to convert is null and the id is valued begin initializing the opportunity and lead
        if (oppToConvert == null && !String.isblank(oppId) && firstRun) {
            
            // if the opportunity to convert is null and the oppid exists in the page parameters do a query for it
        	oppToConvert = [SELECT id,name  FROM Opportunity WHERE id =: oppId];
        	
            // if the opportunity was found
            if(oppToConvert != null) 
              
                // look for the lead that the opportunity was converted from
                convertedLead = [SELECT name,firstname,lastname, company FROM Lead WHERE ConvertedOpportunityId =: oppId ALL ROWS];
            
            
            firstRun = false;
        }
        
		return oppToConvert;        
    }
    
    // lead used for allowing the user to value fields for the new lead.
    private Lead inputLead;
    public Lead getInputLead () {
        return inputLead;
    }
    
    public void setInputLead (lead value) {
        inputLead = value;
    }
    
    // the lead that the opportunity was converted from
    private Lead convertedLead;
    public Lead getConvertedLead () {
        if (convertedLead == null && firstRun)
            getOppToConvert();
        return convertedLead;
    } 
    
    // this method will create a new lead based on the opportunity selected
    public PageReference convertToLead () {
        PageReference returnRef;
        
        if(convertedLead != null) {
        	
            Lead newLead = new lead(firstName = convertedLead.firstname, lastName = convertedLead.lastName, company = convertedLead.company);    
        	
            // if the new lead was succesfully valued
            if(newLead != null) {
				// insert the new lead
            	insert newLead;
                // update the return reference to send the user to the newly created lead
                returnRef = new PageReference('/' + newLead.id); 
            }     
        }
        
        return returnRef;
        
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