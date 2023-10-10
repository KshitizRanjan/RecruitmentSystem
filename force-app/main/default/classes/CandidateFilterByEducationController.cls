public with sharing class CandidateFilterByEducationController {
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> searchCandidatesByEducation(String education) {
        String query = 'SELECT Id, Name, Education__c FROM Candidate__c WHERE';
        if (!String.isEmpty(education)) {
            query += ' Education__c = \'' + education + '\'';
        } 

        return Database.query(query);
    }
}