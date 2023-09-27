@isTest
public class PositionValidationTest {

    @isTest
    static void testValidationRule() {
        System.runAs(runTestAsUser()){
        // Create a new Position record
        Position__c position = new Position__c();
        position.Name = 'Test Position';
        position.Close_Date__c = Date.today();
        position.Minimum_Pay__c = 5000;
        position.Maximum_Pay__c = 3000; // This will trigger the validation rule

        // Try to insert the record
        try {
            insert position;
            // If the insert is successful, fail the test
            System.assert(false, 'Validation rule did not throw the expected error.');
        } catch (DmlException e) {
            // Check if the error message contains the expected validation rule error
            System.assert(e.getMessage().contains('Minimum Pay Should not be greater than Maximum Pay'));
        }
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