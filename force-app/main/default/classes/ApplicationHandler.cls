public class ApplicationHandler {

    // This method prevents creating applications for closed positions
    public static void preventClosedPositionApplications(List<Application__c> newApplications) {
        // Collecting Position__c IDs from the new applications
        Set<Id> positionIds = new Set<Id>();

        // Iterate through new applications and gather Position__c IDs
        for (Application__c app : newApplications) {
            if (app.Position__c != null) {
                positionIds.add(app.Position__c);
            }
        }

        // Query closed positions based on the collected Position__c IDs
        List<Position__c> closedPositions = [SELECT Id, Status__c FROM Position__c WHERE Id IN :positionIds AND Status__c = 'Closed'];

        // Map Position__c IDs to their respective statuses for efficient lookup
        Map<Id, String> positionStatusMap = new Map<Id, String>();
        for (Position__c pos : closedPositions) {
            positionStatusMap.put(pos.Id, pos.Status__c);
        }

        // Check if a new application is for a closed position and add an error if true
        for (Application__c app : newApplications) {
            if (app.Position__c != null && positionStatusMap.containsKey(app.Position__c) && positionStatusMap.get(app.Position__c) == 'Closed') {
                app.addError('Cannot create an application for a closed position.');
            }
        }
    }

    // This method prevents creating duplicate applications for the same position by the same candidate
    public static void preventDuplicateApplications(List<Application__c> newApplications) {
        // Collecting Position__c IDs from the new applications
        Set<Id> positionIds = new Set<Id>();

        // Collecting Position__c IDs from the new applications
        for (Application__c app : newApplications) {
            if (app.Position__c != null) {
                positionIds.add(app.Position__c);
            }
        }

        // Query existing applications for the same positions submitted by the current candidate (user)
        Map<Id, Id> existingApplicationsByPosition = new Map<Id, Id>();
        for (Application__c existingApp : [SELECT Id, Position__c FROM Application__c WHERE Position__c IN :positionIds AND Candidate__r.User__c = :UserInfo.getUserId()]) {
            existingApplicationsByPosition.put(existingApp.Position__c, existingApp.Id);
        }

        // Check if a new application is a duplicate and add an error if true
        for (Application__c newApp : newApplications) {
            if (newApp.Position__c != null) {
                Id positionId = newApp.Position__c;
                if (existingApplicationsByPosition.containsKey(positionId)) {
                    newApp.addError('You have already applied for this position.');
                }
            }
        }
    }
}