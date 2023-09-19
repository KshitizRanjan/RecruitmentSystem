trigger CandidateApexSharing on Candidate__c (after insert) {
    
     if(trigger.isInsert){
        
        List<Candidate__Share> candShrs  = new List<Candidate__Share>();
        
        
        Candidate__Share candidateShr;
       
        
        for(Candidate__c cand : trigger.new){
            
            CandidateShr = new Candidate__Share();
            
            
            
            CandidateShr.ParentId = cand.Id;
            
            
           
            CandidateShr.UserOrGroupId = cand.User__c;
           
            
           
            CandidateShr.AccessLevel = 'read';
         
            
            
            CandidateShr.RowCause = Schema.Candidate__Share.RowCause.user__c;
            
            
            
            candShrs.add(CandidateShr);
          
        }
        
        
        Database.SaveResult[] lsr = Database.insert(candShrs,false);
        
        
        Integer i=0;
        
       
        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){
                
                Database.Error err = sr.getErrors()[0];
                
                
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    
                    trigger.newMap.get(candShrs[i].ParentId).
                      addError(
                       'Unable to grant sharing access due to following exception: '
                       + err.getMessage());
                }
            }
            i++;
        }   
    }
    
    
    

}