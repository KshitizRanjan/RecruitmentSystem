public class CQ_KR_Coach_TriggerHandler {

    // Method to handle before update logic for CQ_KR_SQX_Coach__c
    public static void handleBeforeUpdate(List<CQ_KR_SQX_Coach__c> newCoaches, Map<Id, CQ_KR_SQX_Coach__c> oldCoachesMap) {
        // Map to store coach IDs as keys and associated players as values
        Map<Id, List<CQ_KR_SQX_Player__c>> coachToPlayersMap = new Map<Id, List<CQ_KR_SQX_Player__c>>();

        // Iterate through the new coaches being updated
        for (CQ_KR_SQX_Coach__c coach : newCoaches) {
            // Get the old coach for comparison
            CQ_KR_SQX_Coach__c oldCoach = oldCoachesMap.get(coach.Id);

            // Check if the training status is changing from 'In Progress' to 'Completed'
            if (coach.CQ_KR_Training_Status__c == 'Completed' && oldCoach.CQ_KR_Training_Status__c == 'In progress') {
                // If yes, initialize an empty list for associated players
                coachToPlayersMap.put(coach.Id, new List<CQ_KR_SQX_Player__c>());
            }

            // Check if the training status is 'Closed'
            if (oldCoach.CQ_KR_Training_Status__c == 'Closed') {
                // If yes, prevent updating and display an error
                coach.CQ_KR_Training_Status__c.addError(System.label.CQ_KR_UI_Coach_Update_Error);
            }
        }

        // Populate the coachToPlayersMap with associated players who have non-empty resumes
        if (!coachToPlayersMap.isEmpty()) {
            for (CQ_KR_SQX_Player__c player : [SELECT Id, CQ_KR_SQX_Coach__c 
                                              FROM CQ_KR_SQX_Player__c 
                                              WHERE CQ_KR_SQX_Coach__c IN :coachToPlayersMap.keySet() 
                                              AND CQ_KR_Resume__c != NULL]) {
                coachToPlayersMap.get(player.CQ_KR_SQX_Coach__c).add(player);
            }

            // Check if any player has a non-empty resume for coaches with 'Completed' status
            for (CQ_KR_SQX_Coach__c coach : newCoaches) {
                if (coach.CQ_KR_Training_Status__c == 'Completed' && coachToPlayersMap.get(coach.Id).isEmpty()) {
                    // If not, prevent updating and display an error
                    coach.CQ_KR_Training_Status__c.addError(System.label.CQ_KR_UI_Coach_Resume_Error);
                }
            }
        }
    }
}