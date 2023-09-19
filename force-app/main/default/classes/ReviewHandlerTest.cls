@isTest
public class ReviewHandlerTest {

    @isTest
    static void testPreventReviews() {
        // Create a sample application with 'Rejected' status
        Application__c rejectedApp = new Application__c(Status__c='Rejected');
        insert rejectedApp;

        // Create a review for the rejected application
        Review__c review = new Review__c(Application__c=rejectedApp.Id, Status__c='Approved');

        // Try inserting the review
        try {
            insert review;
            // Ensure the review was not inserted for a rejected application
            System.assert(false, 'Review should not have been inserted for a rejected application');
        } catch (DmlException e) {
            // Expecting an error due to the rejected application
            System.assertEquals(1, e.getNumDml());
            // Retrieve and check the error messages
            String errorMessage = e.getDmlMessage(0);
            System.assert(errorMessage.contains('Cannot create a review for an application with a "Rejected" or "Pending" status.'));
        }

        // Clean up after the test
        delete review;
    }

    @isTest
    static void testPreventMultipleReviews() {
        // Create a sample application
        Application__c application = new Application__c();
        insert application;

        // Create two reviews for the same application
        Review__c review1 = new Review__c(Application__c=application.Id);
        Review__c review2 = new Review__c(Application__c=application.Id);

        // Try inserting the reviews
        try {
            insert new List<Review__c>{review1, review2};
            // Ensure the second review was not inserted for the same application
            System.assert(false, 'Second review should not have been inserted for the same application');
        } catch (DmlException e) {
            // Expecting an error due to the second review for the same application
            System.assertEquals(1, e.getNumDml());
            // Retrieve and check the error messages
            String errorMessage = e.getDmlMessage(0);
            System.assert(errorMessage.contains('An existing review record already exists for this application.'));
        }

        // Clean up after the test
        delete review1;
    }

    @isTest
    static void testUpdatePositions() {
        // Create a sample application
        Position__c pos=new Position__c(Name='Jung',Close_Date__c=System.today()+1);
        insert pos;
        Candidate__c candidate=new Candidate__c(Name='Shekhar',Email__c='xyz@abc.com',user__c='0055j000009mUey');
        insert candidate;
        Application__c application = new Application__c(Status__c='Approved', Position__c = pos.id,Candidate__c=candidate.id);
        insert application;

        // Create a review for the application
        Review__c review = new Review__c(Application__c=application.Id, Status__c='Hired',Rating__c=8);
        insert review;

        // Ensure the position's No_Of_Openings__c is updated
        Position__c position = [SELECT Id, No_Of_Openings__c FROM Position__c WHERE Id = :application.Position__c];
        System.assertEquals(0, position.No_Of_Openings__c); // Adjust the expected value based on your data

        // Clean up after the test
        delete review;
    }

    @isTest
    static void testHandleReviewInsert() {
        // Create a sample application
        Application__c application = new Application__c();
        insert application;

        // Create a review for the application
        Review__c review = new Review__c(Application__c=application.Id);

        // Insert the review - this will trigger the handler's method indirectly
        insert review;

        // Ensure the application's Review__c field is updated
        Application__c updatedApplication = [SELECT Id, Review__c FROM Application__c WHERE Id = :application.Id];
        System.assertEquals(true, updatedApplication.Review__c);

        // Clean up after the test
        delete review;
    }
}