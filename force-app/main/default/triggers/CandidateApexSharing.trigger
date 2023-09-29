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
    
    

    }   
}