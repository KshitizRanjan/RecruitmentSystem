@isTest
private class CQ_KR_Test_Validation_Coach {
    
    
    // Helper method to create a user with a specific permission set
    private static User createUserWithPermissionSet() {
        // Retrieve the desired permission set by name
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_KR_Common_Permission_Set' LIMIT 1];
        
        // Retrieve a profile for the user (replace 'Standard User' with the actual profile name)
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; 
        
        // Create a new user with specified attributes
        User u = new User(
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
        insert u;
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = u.Id,
            PermissionSetId = ps.Id
        );
        insert psa;
        
        return u;  // Return the created user
    }
    
    // Test method to validate a custom date validation rule for Coach objects
    @isTest static void givenStartDate_WhenLessThanCompletionDate_ThenNotInsert() {
        System.runAs(createUserWithPermissionSet()) {
            // Create a test Coach record with an intentionally invalid date configuration
            CQ_KR_SQX_Coach__c testCoach = new CQ_KR_SQX_Coach__c(
                Name = 'Test Restaurant',
                CQ_KR_Training_Start_Date__c = Date.today(),
                CQ_KR_Training_Completion_Date__c = Date.today().addDays(-1) // Making target date 1 day before the initiated date
            );
            
            // Define an exception variable to capture the expected validation exception
            Test.startTest();
            Database.saveresult Result=Database.insert(testCoach,false);
            Test.stopTest();
            System.assert(!Result.isSuccess());
        }
    }
}