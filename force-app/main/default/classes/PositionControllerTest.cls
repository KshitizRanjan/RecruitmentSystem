@isTest
public class PositionControllerTest {

    @isTest
    static void testGetOpenPositions() {
        // Create 'Open' positions
        List<Position__c> openPositions = new List<Position__c>();
        for (Integer i = 0; i < 5; i++) {
            openPositions.add(new Position__c(Name = 'Open Position ' + i, Status__c = 'Open',Close_Date__c=System.Today()+1));
        }
        insert openPositions;

        // Create 'Closed' positions (to verify the query)
        List<Position__c> closedPositions = new List<Position__c>();
        for (Integer i = 0; i < 3; i++) {
            closedPositions.add(new Position__c(Name = 'Closed Position ' + i, Status__c = 'Closed',Close_Date__c=System.Today()+1));
        }
        insert closedPositions;

        // Call the controller method
        List<Position__c> openPositionsResult = PositionController.getOpenPositions();

        // Verify the result
        System.assertEquals(5, openPositionsResult.size());

        // Clean up the data
        delete openPositions;
        delete closedPositions;
    }
}