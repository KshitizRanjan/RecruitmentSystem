public with sharing class ObjectDetailController {
    @AuraEnabled(cacheable=true)
    public static List<Application__c> getObjectDetails() {
List<Application__c> app = [SELECT Id, Status__c, Position__r.Name FROM Application__c WHERE Position__r.Name!=NULL LIMIT 12];


 

                return app;



}
}