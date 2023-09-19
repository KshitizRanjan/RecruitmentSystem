public class ApplicationHandler {
    

    public static void preventClosedPositionApplications(List<Application__c> newApplications) {
        Set<Id> positionIds = new Set<Id>();

        for (Application__c app : newApplications) {
            if (app.Position__c != null) {
                positionIds.add(app.Position__c);
            }
        }

        List<Position__c> closedPositions = [SELECT Id, Status__c FROM Position__c WHERE Id IN :positionIds AND Status__c = 'Closed'];

        Map<Id, String> positionStatusMap = new Map<Id, String>();
        for (Position__c pos : closedPositions) {
            positionStatusMap.put(pos.Id, pos.Status__c);
        }

        for (Application__c app : newApplications) {
            if (app.Position__c != null && positionStatusMap.containsKey(app.Position__c) && positionStatusMap.get(app.Position__c) == 'Closed') {
                app.addError('Cannot create an application for a closed position.');
            }
        }
    }

    public static void preventDuplicateApplications(List<Application__c> newApplications) {
        Set<Id> positionIds = new Set<Id>();

        // Collect the Position__c (lookup) field values from the newly inserted applications
        for (Application__c app : newApplications) {
            if (app.Position__c != null) {
                positionIds.add(app.Position__c);
            }
        }

        // Query existing applications for the same positions submitted by the current candidate (user)
        Map<Id, Id> existingApplicationsByPosition = new Map<Id, Id>();
        for (Application__c existingApp : [SELECT Id, Position__c
                                            FROM Application__c
                                            WHERE Position__c IN :positionIds
                                            AND Candidate__r.User__c = :UserInfo.getUserId()]) {
            existingApplicationsByPosition.put(existingApp.Position__c, existingApp.Id);
        }

        // Check if the candidate (user) has already applied for the same position
        for (Application__c newApp : newApplications) {
            if (newApp.Position__c != null) {
                Id positionId = newApp.Position__c;
                if (existingApplicationsByPosition.containsKey(positionId)) {
                    
                    newApp.addError('You have already applied for this position. ' 
                                 );
                }
            }
        }
    }
}