@isTest
public class CandidateFilterByEducationControllerTest {

    @isTest
    static void testSearchCandidatesByEducation() {
        // Create a test candidate
        Candidate__c candidate = new Candidate__c(Name = 'Test Candidate', Education__c = 'Ph.d',Email__c='test@testmail.com');
        insert candidate;

        // Call the controller method
        List<Candidate__c> resultCandidates = CandidateFilterByEducationController.searchCandidatesByEducation('Ph.d');

        // Verify the result
        System.assertEquals(1, resultCandidates.size());
        System.assertEquals('Test Candidate', resultCandidates[0].Name);
        System.assertEquals('Ph.D', resultCandidates[0].Education__c);
    }
}