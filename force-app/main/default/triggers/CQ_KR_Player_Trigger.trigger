trigger CQ_KR_Player_Trigger on CQ_KR_SQX_Player__c (before update,after insert, after delete) {
    if(trigger.isBefore && trigger.isUpdate){
    CQ_KR_Player_TriggerHandler.handleBeforeUpdate(Trigger.new,Trigger.oldMap);
        
    }
    if(trigger.isAfter && trigger.isInsert){
        
         CQ_KR_Player_TriggerHandler.handleAfterMethod(Trigger.new); 
        
    }
    if(trigger.isAfter && trigger.isDelete){
        
         CQ_KR_Player_TriggerHandler.handleAfterMethod(Trigger.old); 
        
    }
    
    
}