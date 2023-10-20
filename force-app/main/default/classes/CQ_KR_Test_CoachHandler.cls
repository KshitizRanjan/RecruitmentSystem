@isTest
private class CQ_KR_Test_CoachHandler {
    
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
    
    @isTest static void givenCoach_WhenUpdate_ThenAssertError() {
        // Run the test as the user with the specified permission set
        System.runAs(createUserWithPermissionSet()) {
            // 1. Insert a coach record with 'In progress' status
            CQ_KR_SQX_Coach__c testCoach = new CQ_KR_SQX_Coach__c(CQ_KR_Training_Status__c = 'In progress');
            insert testCoach;
            
            // 2. Try updating the coach's training status to 'Completed' without an associated player having a non-empty resume
            Test.startTest();
            testCoach.CQ_KR_Training_Status__c = 'Completed';
            Database.SaveResult result = Database.update(testCoach, false);
            Test.stopTest();
            System.assert(!result.isSuccess(), 'Expected error when updating the coach status to Completed without any player having a non-empty resume');
            
            // Insert a player associated with the coach and with a non-empty resume
            CQ_KR_SQX_Player__c testPlayer = new CQ_KR_SQX_Player__c(CQ_KR_SQX_Coach__c = testCoach.Id, CQ_KR_Resume__c = 'Test Resume');
            insert testPlayer;
            
            // Try updating the coach's training status to 'Completed' again with the associated player having a non-empty resume
            testCoach.CQ_KR_Training_Status__c = 'Completed';
            update testCoach;
            
            // 3. Insert another coach record with 'Closed' status
            CQ_KR_SQX_Coach__c closedCoach = new CQ_KR_SQX_Coach__c(CQ_KR_Training_Status__c = 'Closed');
            insert closedCoach;
            
            // Try updating the closed coach
            closedCoach.CQ_KR_Training_Status__c = 'Completed';
            result = Database.update(closedCoach, false);
            System.assert(!result.isSuccess(), 'Expected error when updating a coach with a training status of Closed');
            
            // Ensure the coach has not been updated
            CQ_KR_SQX_Coach__c refreshedCoach = [SELECT CQ_KR_Training_Status__c FROM CQ_KR_SQX_Coach__c WHERE Id = :closedCoach.Id LIMIT 1];
            System.assertEquals('Closed', refreshedCoach.CQ_KR_Training_Status__c);
        }
    }
}