@isTest
public class ApplicationApprovalFlowTest {

    @isTest
    static void testSubmitForApproval() {
         System.runAs(runTestAsUser()){
        // Create a test Application record with status 'Pending'
        Application__c application = new Application__c();
        application.Status__c = 'Pending';
        

        // Set up the record create trigger event
        Test.startTest();
        // Insert application (triggering the flow)
        insert application;
        Test.stopTest();

        // Verify that the flow sent the application for approval
        // In this case, we'll check if the record is submitted for approval.
        List<ProcessInstance> processInstances = [SELECT Id, Status FROM ProcessInstance WHERE TargetObjectId = :application.Id];
        System.assertNotEquals(0, processInstances.size());
        System.assertEquals('Pending', processInstances[0].Status);
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