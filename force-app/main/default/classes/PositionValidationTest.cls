@isTest
public class PositionValidationTest {

    @isTest
    static void testValidationRule() {
        // Create a new Position record
        Position__c position = new Position__c();
        position.Name = 'Test Position';
        position.Close_Date__c = Date.today();
        position.Minimum_Pay__c = 5000;
        position.Maximum_Pay__c = 3000; // This will trigger the validation rule

        // Try to insert the record
        try {
            insert position;
            // If the insert is successful, fail the test
            System.assert(false, 'Validation rule did not throw the expected error.');
        } catch (DmlException e) {
            // Check if the error message contains the expected validation rule error
            System.assert(e.getMessage().contains('Minimum Pay Should not be greater than Maximum Pay'));
        }
    }
}