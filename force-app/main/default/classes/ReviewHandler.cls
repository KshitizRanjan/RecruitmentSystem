public class ReviewHandler {
    // Prevents reviews for applications with 'Rejected' or 'Pending' status
    public static void preventReviews(List<Review__c> reviews) {
        Set<Id> rejectedAppIds = new Set<Id>();
        String errorMessage = System.Label.reviewstatus;
        // Collect the IDs of related applications
        for (Review__c review : reviews) {
            if (review.Application__c != null) {
                rejectedAppIds.add(review.Application__c);
            }
        }

        // Query the status of related applications
        Map<Id, Application__c> appMap = new Map<Id, Application__c>([SELECT Id, Status__c FROM Application__c WHERE Id IN :rejectedAppIds]);

        // Iterate through the reviews to verify the application status
        for (Review__c review : reviews) {
            if (review.Application__c != null) {
                Application__c app = appMap.get(review.Application__c);

                // If the related application status is 'Rejected' or 'Pending,' prevent the review from being created
                if (app != null && (app.Status__c == 'Rejected' || app.Status__c == 'Pending')) {
                    review.addError(errorMessage);
                }
            }
        }
    }

   public static void updatePositions(List<Review__c> reviews) {
    Set<Id> applicationIdsToUpdate = new Set<Id>();
    Map<Id, Position__c> positionsToUpdate = new Map<Id, Position__c>();

    // Iterate through the reviews to identify records with Status 'Hired'
    for (Review__c review : reviews) {
        if (review.Status__c == 'Hired') {
            applicationIdsToUpdate.add(review.Application__c);
        }
    }

    // Query the related Application records
    List<Application__c> applications = [SELECT Id, Position__c FROM Application__c WHERE Id IN :applicationIdsToUpdate];

    // Collect Position__c IDs
    Set<Id> positionIds = new Set<Id>();
    for (Application__c application : applications) {
        if (application.Position__c != null) {
            positionIds.add(application.Position__c);
        }
    }

    // Query Position__c records in bulk
    Map<Id, Position__c> positionMap = new Map<Id, Position__c>([SELECT Id, No_Of_Openings__c FROM Position__c WHERE Id IN :positionIds]);

    // Update Position__c records based on the application data
    for (Application__c application : applications) {
        if (application.Position__c != null) {
            Position__c position = positionMap.get(application.Position__c);
            if (position != null && position.No_Of_Openings__c > 0) {
                // Update the No. Of Position field by reducing it by 1
                position.No_Of_Openings__c -= 1;
                positionsToUpdate.put(position.Id, position);
            }
        }
    }

    // Update the Position records
    
        if (positionsToUpdate != null) {
                 update positionsToUpdate.values();
              }
       else {
               System.debug('positionsToUpdate is null. Unable to perform the update.');
              }
}


    // Handles the insertion of reviews and updates the corresponding applications
    public static void handleReviewInsert(List<Review__c> newReviews) {
        List<Id> applicationIdsToUpdate = new List<Id>();

        // Collect the Application Ids related to the inserted Reviews
        for (Review__c review : newReviews) {
            if (review.Application__c != null) {
                applicationIdsToUpdate.add(review.Application__c);
            }
        }

        if (!applicationIdsToUpdate.isEmpty()) {
            // Query and update Application records with related Reviews
            List<Application__c> applicationsToUpdate = [SELECT Id FROM Application__c WHERE Id IN :applicationIdsToUpdate];

            for (Application__c application : applicationsToUpdate) {
                application.Review__c = true; // Set the Review checkbox to true
            }

            // Update the Application records
            update applicationsToUpdate;
        }
    }

    // Prevents multiple reviews for the same application
    public static void preventMultipleReviews(List<Review__c> newReviews) {
        Set<Id> applicationIds = new Set<Id>();
        String errorMessage = System.Label.reviewrepeat;

        for (Review__c review : newReviews) {
            applicationIds.add(review.Application__c);
        }

        // Query for existing Review records related to the same Application IDs
        Map<Id, Integer> appReviewCount = new Map<Id, Integer>();
        for (Review__c existingReview : [SELECT Id, Application__c FROM Review__c WHERE Application__c IN :applicationIds]) {
            Id appId = existingReview.Application__c;
            appReviewCount.put(appId, appReviewCount.containsKey(appId) ? appReviewCount.get(appId) + 1 : 1);
        }

        // Check if there are multiple reviews for the same application and add an error
        for (Review__c newReview : newReviews) {
            Id appId = newReview.Application__c;
            if (appReviewCount.containsKey(appId) && appReviewCount.get(appId) > 0) {
                newReview.addError(errorMessage);
            }
        }
    }
}