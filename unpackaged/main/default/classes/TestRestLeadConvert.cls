@isTest 
global with sharing class TestRestLeadConvert { 
static testMethod void validateLeadconvert() { 
final Account account = new Account(name='Chromos'); 
Id accountId = account.Id; 
final Lead lead = new Lead(firstname='Apex Testing', lastname='Lead', company='Chromos'); 
insert lead; 
Id leadId = lead.Id; 
RestRequest request = new RestRequest(); 
RestResponse response = new RestResponse(); 
request.httpMethod = 'GET'; 
request.addParameter('Id', leadId); 
request.addParameter('AccountId', accountId); 
RestContext.request = request; 
RestContext.response = response; 
final Map<String, String> result = RestLeadConvert.startProcessing(); System.assertEquals((String) leadId, result.get('leadId')); 
} 
}