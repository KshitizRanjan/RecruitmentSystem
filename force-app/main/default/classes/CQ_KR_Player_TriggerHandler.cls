public class CQ_KR_Player_TriggerHandler {
    
    // Handle logic before updating player records
    public static void handleBeforeUpdate(List<CQ_KR_SQX_Player__c> newPlayers, Map<Id, CQ_KR_SQX_Player__c> oldMap) {
        // Collect parent coach IDs for affected players
        Set<Id> coachIds = new Set<Id>();
        for (CQ_KR_SQX_Player__c player : newPlayers) {
            coachIds.add(player.CQ_KR_SQX_Coach__c);
        }
        
        // Retrieve coach information for the associated players
        Map<Id, CQ_KR_SQX_Coach__c> coaches = new Map<Id, CQ_KR_SQX_Coach__c>(
            [SELECT Id, CQ_KR_Training_Status__c FROM CQ_KR_SQX_Coach__c WHERE Id IN :coachIds]
        );
        
        // Check if any child record is associated with a restricted parent and prevent updates
        for (CQ_KR_SQX_Player__c player : newPlayers) {
            CQ_KR_SQX_Coach__c coach = coaches.get(player.CQ_KR_SQX_Coach__c);
            CQ_KR_SQX_Player__c oldPlayer = oldMap.get(player.Id);
            
            // Prevent changing the coach in the middle
            if (oldPlayer.CQ_KR_SQX_Coach__c != player.CQ_KR_SQX_Coach__c) {
                player.addError(System.label.CQ_KR_UI_Player_Parent_Error);
            }
            
            // Prevent editing if the coach's training status is completed or closed
            if (coach.CQ_KR_Training_Status__c == 'Completed' || coach.CQ_KR_Training_Status__c == 'Closed') {
                player.addError(System.label.CQ_KR_UI_Player_Edit_Error);
            }
        }
    }
    
    // Handle logic after updating player records
    public static void handleAfterMethod(List<CQ_KR_SQX_Player__c> players) {
        Set<Id> coachIdsToUpdate = new Set<Id>();
        
        // Collect coach IDs for players with updates
        for (CQ_KR_SQX_Player__c player : players) {
            if (player.CQ_KR_SQX_Coach__c != null) {
                coachIdsToUpdate.add(player.CQ_KR_SQX_Coach__c);
            }
        }
        
        // Count the number of players for each coach
        List<AggregateResult> results = [
            SELECT CQ_KR_SQX_Coach__c, COUNT(Id) playerCount
            FROM CQ_KR_SQX_Player__c
            WHERE CQ_KR_SQX_Coach__c IN :coachIdsToUpdate
            GROUP BY CQ_KR_SQX_Coach__c
        ];
        
        // Map coach IDs to the count of associated players
        Map<Id, Integer> coachToPlayerCount = new Map<Id, Integer>();
        for (AggregateResult ar : results) {
            coachToPlayerCount.put((Id)ar.get('CQ_KR_SQX_Coach__c'), (Integer)ar.get('playerCount'));
        }
        
        // Prepare coaches for updating
        List<CQ_KR_SQX_Coach__c> coachesToUpdate = new List<CQ_KR_SQX_Coach__c>();
        
        // Update the coach records based on the player count
        for (Id coachId : coachIdsToUpdate) {
            CQ_KR_SQX_Coach__c coach = new CQ_KR_SQX_Coach__c(Id = coachId);
            coach.CQ_KR_Child__c = (coachToPlayerCount.containsKey(coachId) && coachToPlayerCount.get(coachId) > 0) ? 'Yes' : 'No';
            coachesToUpdate.add(coach);
        }
        
        // Perform updates if coaches need to be updated
        if (!coachesToUpdate.isEmpty()) {
            update coachesToUpdate;
        }
    }
}