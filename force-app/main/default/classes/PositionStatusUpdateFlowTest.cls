@isTest
public class PositionStatusUpdateFlowTest {

    @isTest
    static void testPositionStatuUpdate() {
        System.runAs(runTestAsUser()){
        // Create a test Position record
        Position__c position = new Position__c();
        position.Name = 'Test Position';
        position.No_of_Openings__c = 0;
        position.Status__c = 'Open';
        position.Close_Date__c=System.today()+1;
        insert position;

        // Set up the record update trigger event
        position.Status__c = 'Open';
        Test.startTest();
        update position;
        Test.stopTest();

        // Retrieve the updated position record
        Position__c updatedPosition = [SELECT Id, Status__c FROM Position__c WHERE Id = :position.Id];

        // Verify that the flow updated the status to 'Closed'
        System.assertEquals('Closed', updatedPosition.Status__c);
    }
    }
       // Helper method to set up the user context and run test methods
    private static user runTestAsUser() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Interview Parties 2'];  

       
        // Assuming 'YourPermissionSetName' is the API name of the permission set you want to assign
        PermissionSet permSet = [SELECT Id FROM PermissionSet WHERE Name = 'Candidate_2'];

        User testUser = new User(
            Alias = 'testUser',
            Email = 'testuser@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = profile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'kshitiz@gupta.com'
        );

        insert testUser;
        // Assign the permission set to the user
        PermissionSetAssignment psa = new PermissionSetAssignment(
            PermissionSetId = permSet.Id,
            AssigneeId = testUser.Id
        );
        insert psa;

       return testUser;

        
    }
}