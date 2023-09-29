@isTest
public class ReviewHandlerTest {
    
    @isTest 
    static void testPreventReviews() {
        System.runAs(runTestAsUser())
        {
            // Create a sample application with 'Rejected' status
            Application__c rejectedApp = new Application__c(Status__c='Rejected');
            insert rejectedApp;
            
            // Create a review for the rejected application
            Review__c review = new Review__c(Application__c=rejectedApp.Id, Status__c='On Hold',Rating__c=8);
            boolean flag=false;
            // Try inserting the review
            try {
                insert review;
                // Ensure the review was not inserted for a rejected application
                System.assert(false, 'Review should not have been inserted for a rejected application');
                flag=true;
            } catch (DmlException e) {
                // Expecting an error due to the rejected application
                System.assertEquals(1, e.getNumDml());
                // Retrieve and check the error messages
                String errorMessage = e.getDmlMessage(0);
                System.assert(errorMessage.contains(System.label.reviewstatus));
            }
            
            // Clean up after the test
            if(flag){
                delete review;
            }
        }
    }
    
    @isTest
    static void testPreventMultipleReviews() {
        System.runAs(runTestAsUser())
        {
            Position__c position=new Position__c(Name='Test Position',Close_Date__c=System.today()-1);
            insert position;
            String currentUser=[Select id from user where Username=: UserInfo.getUserName()].id;
            
            Candidate__c cand=new Candidate__c(Name='Jung',Email__c='Test@usermail.com',user__c=currentUser);
            Insert cand;
            // Create a sample application
            Application__c application = new Application__c(Position__c=position.Id,Candidate__c=cand.Id,status__c='Approved');
            insert application;
            
            // Create two reviews for the same application
            Review__c review1 = new Review__c(Application__c=application.Id,Rating__c=8);
            Review__c review2 = new Review__c(Application__c=application.Id,Rating__c=9);
            
            // Try inserting the reviews
            try {
                insert new List<Review__c>{review1, review2};
                    // Ensure the second review was not inserted for the same application
                    
                    } catch (DmlException e) {
                        // Expecting an error due to the second review for the same application
                        System.assertEquals(2, e.getNumDml());
                        
                        // Retrieve and check the error messages for both DML operations
                        String errorMessage1 = e.getDmlMessage(0);
                        String errorMessage2 = e.getDmlMessage(1);
                        
                        // Check if either of the error messages contains the expected message
                        System.assert(
                            errorMessage1.contains(System.label.reviewrepeat) ||
                            errorMessage2.contains(System.label.reviewrepeat)
                        );
                        
                    }
            
            // Clean up after the test
            delete review1;
        }
    }
    
    @isTest
    static void testUpdatePositions() {
        System.runAs(runTestAsUser())
        {
            // Create a sample application
            Position__c pos=new Position__c(Name='Jung',Close_Date__c=System.today()+1);
            insert pos;
            String currentUser=[Select id from user where Username=: UserInfo.getUserName()].id;
            Candidate__c candidate=new Candidate__c(Name='Shekhar',Email__c='xyz@abc.com',user__c=currentUser);
            insert candidate;
            Application__c application = new Application__c(Status__c='Approved', Position__c = pos.id,Candidate__c=candidate.id);
            insert application;
            
            // Create a review for the application
            Review__c review = new Review__c(Application__c=application.Id,Rating__c=8);
            insert review;
            review.Status__c='Hired';
            update review;
            
            // Ensure the position's No_Of_Openings__c is updated
            Position__c position = [SELECT Id, No_Of_Openings__c FROM Position__c WHERE Id = :application.Position__c];
            System.assertEquals(0, position.No_Of_Openings__c); // Adjust the expected value based on your data
            
            // Clean up after the test
            delete review;
        }
    }
    
    @isTest
    static void testHandleReviewInsert() {
        System.runAs(runTestAsUser())
        {
            
            Position__c position=new Position__c(Name='Test Position',Close_Date__c=System.today()-1);
            insert position;
            String currentUser=[Select id from user where Username=: UserInfo.getUserName()].id;
            Candidate__c cand=new Candidate__c(Name='Jung',Email__c='Test@usermail.com',user__c=currentUser);
            Insert cand;
            
            // Create a sample application
            
            Application__c application = new Application__c(Candidate__c=cand.Id,Position__c=position.id,Status__c='Approved');
            insert application;
            
            // Create a review for the application
            Review__c review = new Review__c(Application__c=application.Id,Rating__c=9,Status__c='On Hold');
            
            // Insert the review - this will trigger the handler's method indirectly
            insert review;
            
            // Ensure the application's Review__c field is updated
            Application__c updatedApplication = [SELECT Id, Review__c FROM Application__c WHERE Id = :application.Id];
            System.assertEquals(true, updatedApplication.Review__c);
            
            // Clean up after the test
            delete review;
        }
    }
    
    // Helper method to set up the user context and run test methods
    private static user runTestAsUser() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Interview Parties 2'];  
        
        
        // Assuming 'YourPermissionSetName' is the API name of the permission set you want to assign
        PermissionSet permSet = [SELECT Id FROM PermissionSet WHERE Name = 'Candidate_2'];
        
        User testUser = new User(
            Alias = 'testUser',
            Email = 'testuser@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = profile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'kshitiz@gupta.com'
        );
        
        insert testUser;
        // Assign the permission set to the user
        PermissionSetAssignment psa = new PermissionSetAssignment(
            PermissionSetId = permSet.Id,
            AssigneeId = testUser.Id
        );
        insert psa;
        
        return testUser;
        
        
    }
    
    
    
    
}