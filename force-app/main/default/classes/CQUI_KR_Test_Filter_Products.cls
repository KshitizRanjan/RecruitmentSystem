@isTest
public class CQUI_KR_Test_Filter_Products {
    
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
    
    // Test method to validate filtering products based on search term and part family
    @isTest
    static void givenPartFamily_WhenEnter_ThenAssertFilter() {
        // Run the test as a specific user with appropriate permissions
        user test=[select id , username from user where UserName = 'standarduser@testo1rg.com' LIMIT 1];
        System.runAs(test) {
            // Setup Part Family test data
            compliancequest__SQX_Part_Family__c partFamily = new compliancequest__SQX_Part_Family__c(Name = 'TestFamily');
            insert partFamily;
            
            // Setup SQX Part test data
            compliancequest__SQX_Part__c part1 = new compliancequest__SQX_Part__c(
                Name = 'TestPart1',
                compliancequest__Part_Number__c = '12345',
                compliancequest__Part_Type__c = 'TypeA',
                compliancequest__Part_Risk_Level__c = 5,
                compliancequest__Part_Family__c = partFamily.Id // Assigning the Part Family to the Part
            );
            
            insert part1;
            
            // Test with searchTerm and part family
            Map<String, Object> currentRecord = new Map<String, Object> {
                'CQ_KR_SQX_Part_Family__c' => part1.compliancequest__Part_Family__c
                    };
                        List<SObject> result = CQUI_KR_Filter_Products_By_ProductFamily.getRecords(currentRecord, 'TestPart1');
            System.assertEquals(1, result.size(), 'Expected one record');
            
            // Test with searchTerm but without part family
            currentRecord.put('CQ_KR_SQX_Part_Family__c', null);
            result = CQUI_KR_Filter_Products_By_ProductFamily.getRecords(currentRecord, 'TestPart1');
            System.assertEquals(0, result.size(), 'Expected zero records without part family');
            
            // Test without searchTerm but with part family
            currentRecord.put('CQ_KR_SQX_Part_Family__c', part1.compliancequest__Part_Family__c);
            result = CQUI_KR_Filter_Products_By_ProductFamily.getRecords(currentRecord, '');
            System.assertEquals(1, result.size(), 'Expected one record without searchTerm');
            
            // Test without currentRecord
            result = CQUI_KR_Filter_Products_By_ProductFamily.getRecords(null, 'TestPart1');
            System.assertEquals(0, result.size(), 'Expected zero records without currentRecord');
        }
    }
}