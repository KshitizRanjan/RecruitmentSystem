trigger CQ_KR_Coach_Trigger on CQ_KR_SQX_Coach__c (before update) {
    CQ_KR_Coach_TriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
}