@isTest
public class ApplicationTriggerTest {
    
    @isTest
    static void testPreventClosedPositionApplications() {
         System.runAs(runTestAsUser())
        {
        // Create a closed position
        Position__c closedPosition = new Position__c(Name='Closed Position', Status__c='Closed',Close_Date__c=System.today()+1);
        insert closedPosition;
        
        // Create an application for the closed position
        Application__c closedApp = new Application__c(Position__c=closedPosition.Id);
        
        try {
            insert closedApp;
            // Ensure the application was not inserted due to a closed position
            System.assert(false, 'Application should not have been inserted for a closed position');
        } catch (DmlException e) {
            // Expecting an error due to the closed position
            System.assert(e.getNumDml() == 1);
            // Retrieve and check the error messages
            String errorMessage = e.getDmlMessage(0);
            System.assert(errorMessage.contains(System.label.appstatus));
        }
        }
    }
    
    @isTest
    static void testPreventDuplicateApplications() {
        System.runAs(runTestAsUser()){
        User u=runTestAsUser();
        // Create a position
        Position__c position = new Position__c(Name='Test Position', Status__c='Open',Close_Date__c=System.today()+1);
        insert position;
        
        // Create an application for the position
        Application__c app = new Application__c(Position__c=position.Id);
        insert app;
        
        // Try creating another application for the same position by the same user
        Application__c duplicateApp = new Application__c(Position__c=position.Id);
        
        try {
            insert duplicateApp;
            // Ensure the application was not inserted due to a duplicate application
            
        } catch (DmlException e) {
            // Expecting an error due to the duplicate application
            System.assert(e.getNumDml() == 2);
            // Retrieve and check the error messages
            String errorMessage = e.getDmlMessage(0);
            
            System.assert(errorMessage.contains(System.label.appstatus));
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