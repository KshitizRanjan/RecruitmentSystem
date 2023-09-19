@isTest
public class ApplicationTriggerTest {
    
    @isTest
    static void testPreventClosedPositionApplications() {
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
            System.assert(errorMessage.contains('Cannot create an application for a closed position.'));
        }
    }
    
    @isTest
    static void testPreventDuplicateApplications() {
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
            System.assert(false, 'Duplicate application should not have been inserted.');
        } catch (DmlException e) {
            // Expecting an error due to the duplicate application
            System.assert(e.getNumDml() == 1);
            // Retrieve and check the error messages
            String errorMessage = e.getDmlMessage(0);
            System.assert(errorMessage.contains('You have already applied for this position.'));
        }
    }
    
    
}