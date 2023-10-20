@isTest
public class CQ_KR_Test_PlayerHandler {
    
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
    
    @isTest
    static void givenCoach_WhenChangeCoach_ThenAssertError() {
        // Run the test as the user with the specified permission set
        user test=[select id , username from user where UserName = 'standarduser@testo1rg.com' LIMIT 1];
        System.runAs(test) {
            // Insert a Coach record with 'In progress' status
            CQ_KR_SQX_Coach__c coach = new CQ_KR_SQX_Coach__c(CQ_KR_Training_Status__c = 'In progress');
            insert coach;
            
            // Insert another Coach record with 'Completed' status
            CQ_KR_SQX_Coach__c coach2 = new CQ_KR_SQX_Coach__c(CQ_KR_Training_Status__c = 'Completed');
            insert coach2;
            
            // Insert a Player record associated with the first coach
            CQ_KR_SQX_Player__c player = new CQ_KR_SQX_Player__c(CQ_KR_SQX_Coach__c = coach.Id);
            insert player;
            
            // Update the Player record's associated coach to the second coach
            
            player.CQ_KR_SQX_Coach__c = coach2.Id;
            Database.SaveResult result = Database.update(player, false);
            
            
            // Assert that an error is thrown due to changing the parent when training status is Completed or Closed
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals(System.label.CQ_KR_UI_Player_Edit_Error, result.getErrors()[0].getMessage());
        }
    }
    
    @isTest
    static void givenCoach_WhenAlterPlayer_ThenAssertChildValue() {
        // Run the test as the user with the specified permission set
        user test=[select id , username from user where UserName = 'standarduser@testo1rg.com' LIMIT 1];
        System.runAs(test) {
            // Insert a Coach record with 'In progress' status
            CQ_KR_SQX_Coach__c coach = new CQ_KR_SQX_Coach__c(CQ_KR_Training_Status__c = 'In progress');
            insert coach;
            
            // Insert a Player record associated with the above coach
            CQ_KR_SQX_Player__c player = new CQ_KR_SQX_Player__c(CQ_KR_SQX_Coach__c = coach.Id);
            insert player;
            
            
            
            // Call the after method to handle player updates
            CQ_KR_Player_TriggerHandler.handleAfterMethod(new List<CQ_KR_SQX_Player__c> { player });
            
            
            
            // Assert that the Coach record's CQ_KR_Child__c field is updated to 'Yes'
            coach = [SELECT CQ_KR_Child__c FROM CQ_KR_SQX_Coach__c WHERE Id = :coach.Id LIMIT 1];
            System.assertEquals('Yes', coach.CQ_KR_Child__c);
        }
    }
}