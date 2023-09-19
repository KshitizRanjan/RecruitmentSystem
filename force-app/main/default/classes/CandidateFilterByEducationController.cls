public with sharing class CandidateFilterByEducationController {
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> searchCandidatesByEducation(String education) {
        String query = 'SELECT Id, Name, Education__c FROM Candidate__c WHERE';
        if (!String.isEmpty(education)) {
            query += ' Education__c = \'' + education + '\'';
        } else {
            // Return an empty list if no education criteria is provided
            return new List<Candidate__c>();
        }

        return Database.query(query);
    }
}