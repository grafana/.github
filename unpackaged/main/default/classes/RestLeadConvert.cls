@RestResource(urlMapping='/convert/lead') 
global with sharing class RestLeadConvert { 
@HttpGet 
global static Map<String, String> startProcessing() { 
String responseMessage = 'fail'; 
RestRequest req = RestContext.request; 
Map<String, String> requestParams = req.params; 
String leadId = requestParams.get('Id');
String accountId = requestParams.get('AccountId'); 
//get the status for converted Lead 
LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1]; 
//create the leadConvert object 
Database.LeadConvert lc = new 
Database.LeadConvert(); 
lc.setConvertedStatus(convertStatus.MasterLabel); lc.setDoNotCreateOpportunity(true); 
lc.setAccountId(accountId); 
lc.setLeadId(leadId); 
RestResponse response = RestContext.response; 
Map<String, String> responseParams = new 
Map<String, String>(); 
Database.LeadConvertResult lcr ; 
try{ 
lcr = Database.convertLead(lc); 
// responseParams.put('isSuccess', 
lcr.isSuccess(); 
responseParams.put('leadId', lcr.getLeadID()); 
responseParams.put('accountId', 
lcr.getAccountId()); 
responseParams.put('contactId', 
lcr.getContactId()); 
system.debug('*****lcr.isSuccess()'+lcr.isSuccess()); } 
catch(exception ex){ 
responseParams.put('error', ex.getMessage()); system.debug('***NOT CONVERTED**' + ex);
} 
return responseParams; 
} 
}