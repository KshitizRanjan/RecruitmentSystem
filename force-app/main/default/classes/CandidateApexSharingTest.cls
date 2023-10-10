@isTest
public class CandidateApexSharingTest {

 

    static testMethod void testCandidateSharing() {
     Profile profiles1 = [SELECT Id FROM Profile where name='Interview Parties' limit 1];
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'gyanesh@mail.com',
            Email = 'gyanesh@mail.com',
            Alias = 'tuser',
            ProfileId = profiles1.id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US');
        insert testUser;
        System.debug(testUser.id+'"------------------------------------------"');

 

        Candidate__c testCandidate = new Candidate__c(
            Email__c = 'John@gmail.com',
            User__c=testUser.id
           );
        insert testCandidate;




 

        Candidate__Share candidateShare = new Candidate__Share();
        candidateShare.ParentId = testCandidate.Id;
        candidateShare.UserOrGroupId = testUser.Id; 
        candidateShare.AccessLevel = 'read'; 
        candidateShare.RowCause = Schema.Candidate__Share.RowCause.user__c;

 

       


 

        
        List<Candidate__Share> candidateShares = [
            SELECT Id, ParentId, UserOrGroupId, AccessLevel, RowCause
            FROM Candidate__Share
            WHERE ParentId = :testCandidate.Id And UserOrGroupId=:testUser.id
        ];

 

        
        System.assertEquals(1, candidateShares.size());
        System.assertEquals(testUser.Id, candidateShares[0].UserOrGroupId);
        System.assertEquals('Read', candidateShares[0].AccessLevel);
        System.assertEquals(Schema.Candidate__Share.RowCause.user__c, candidateShares[0].RowCause);

 

    }
}