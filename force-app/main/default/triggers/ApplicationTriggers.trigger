trigger ApplicationTriggers on Application__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            ApplicationHandler.preventClosedPositionApplications(Trigger.new);
            ApplicationHandler.PreventDuplicateApplications(Trigger.new);
        }
    }
   
}