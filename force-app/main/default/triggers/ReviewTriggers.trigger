trigger ReviewTriggers on Review__c (before insert, after insert, after update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            ReviewHandler.preventMultipleReviews(Trigger.new);
            ReviewHandler.preventReviews(Trigger.new);
        }
    }
    else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            
            
            ReviewHandler.handleReviewInsert(Trigger.new);
        }
        else if (Trigger.isUpdate) {
            Map<review__c,string> statusMap=new Map<review__c,String>();
            for(review__c rev: trigger.new){
                String oldstatus=trigger.oldMap.get(rev.Id).status__c;
                statusMap.put(rev,oldstatus);
            }
            
            ReviewHandler.updatePositions(Trigger.new,statusMap);
        }
    }
}