@isTest
private class CQ_KR_Test_Validation_Coach {
    Private static user testuser;
    
    // Helper method to create a user with a specific permission set
    @testSetup
    static void createUserWithPermissionSet() {
        // Retrieve the desired permission set by name
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_KR_Common_Permission_Set' LIMIT 1];
        
        // Retrieve a profile for the user (replace 'Standard User' with the actual profile name)
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; 
        
        // Create a new user with specified attributes
         testUser = new User(
            ProfileId = p.Id,
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'standarduser@testo1rg.com'
        );
        
        // Insert the user and assign the permission set
        insert testUser;
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = testUser.Id,
            PermissionSetId = ps.Id
        );
        insert psa;
        
          
    }
    
    // Test method to validate a custom date validation rule for Coach objects
    @isTest static void givenStartDate_WhenLessThanCompletionDate_ThenNotInsert() {
        user test=[select id , username from user where UserName = 'standarduser@testo1rg.com' LIMIT 1];
        System.runAs(test) {
            // Create a test Coach record with an intentionally invalid date configuration
            CQ_KR_SQX_Coach__c testCoach = new CQ_KR_SQX_Coach__c(
                Name = 'Test Restaurant',
                CQ_KR_Training_Start_Date__c = Date.today(),
                CQ_KR_Training_Completion_Date__c = Date.today().addDays(-1) // Making target date 1 day before the initiated date
            );
            
            // Define an exception variable to capture the expected validation exception
          
            Database.saveresult Result=Database.insert(testCoach,false);
          
            System.assert(!Result.isSuccess());
        }
    }
}