@isTest
public class PositionStatusUpdateFlowTest {

    @isTest
    static void testPositionStatuUpdate() {
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