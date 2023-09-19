trigger ReviewStatusChangeEmailTrigger on Review__c (after update) {
    // List to store email messages
    List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
    
    for (Review__c review : Trigger.new) {
        // Check if the status has changed
        if (Trigger.oldMap.get(review.Id).Status__c != review.Status__c) {
            // Get the candidate's email from the related Application object
            String candidateEmail = review.Candidate_Email__c;
            
            // Create a new email message
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            // Set the target email address directly
            email.setToAddresses(new String[] { candidateEmail });
            
            // Set the email subject and body
            if (review.Status__c == 'Hired') {
                email.setSubject('Congratulations - You\'ve been Hired!');
                email.setPlainTextBody('Dear ' +review.Candidate_Name__c +',\n\nWe are pleased to inform you that you have been hired for the position'+review.Position_Name__c);
            } else if (review.Status__c == 'Rejected') {
                email.setSubject('We are sorry!');
                email.setPlainTextBody('Dear'+ review.Candidate_Name__c+',\n\nWe regret to inform you that your application has been rejected.');
            }
            
            // Optionally, you can customize other email properties
            // email.setSaveAsActivity(false); // Prevent email from being saved as an activity
            
            // Add the email message to the list
            emailMessages.add(email);
        }
    }
    
    // Send the email messages
    if (!emailMessages.isEmpty()) {
        Messaging.sendEmail(emailMessages);
    }
}