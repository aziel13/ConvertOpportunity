# ConvertOpportunity
Salesforce.com opportunity conversion tool

This a salesforce.com applicaition that will allow you to convert your opportunties into leads. It is a spiritual succsor to unconvert opportunity app exchange package from crmscience. It is primarly intended as a learning tool for understanding how to write a full apex application.  

This project is still a work in progress. 

Install intructions:
1. If you do not have a developer account, create one at developer.salesforce.com
2. Now you will need to create a new lookup field to lead on the opportunity object called ConvertedLeadId. If your not familar with salesforce you need to click setup to bring you to the setup page, then  under the build section click customize -> opportunity -> Fields. Now scroll down to custom fields and click new. Choose the type Lookup Relationship and continue. Choose lead in the dropdown list. after that put in the name ConvertedLeadId in field name put ConvertedLeadId and in field Label put Converted Lead Id. then save the field.
3. The next step is to move the apex files into the org. the simplest way to transfer these in without setting up an ide is to create the class's and visualforce pages using the developer console and copy the code over.
