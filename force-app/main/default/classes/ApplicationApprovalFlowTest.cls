@isTest
public class ApplicationApprovalFlowTest {

    @isTest
    static void testSubmitForApproval() {
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