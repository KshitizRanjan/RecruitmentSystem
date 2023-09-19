public with sharing class PositionController {
    @AuraEnabled(cacheable=true)
    public static List<Position__c> getOpenPositions() {
        // Query and return Position records with Status = 'Open'
        return [SELECT Id, Name, Close_Date__c FROM Position__c WHERE Status__c = 'Open'];
    }
}