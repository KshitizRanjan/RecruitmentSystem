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
            ReviewHandler.updatePositions(Trigger.new);
        }
    }
}