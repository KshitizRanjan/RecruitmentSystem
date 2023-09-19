import { LightningElement, track, wire } from 'lwc';
import searchCandidatesByEducation from '@salesforce/apex/CandidateFilterByEducationController.searchCandidatesByEducation';
import { NavigationMixin } from 'lightning/navigation';

export default class CandidateFilterByEducation extends NavigationMixin(LightningElement) {
    @track education = '';
    @track searchResults = [];

    // Define picklist values for education
    educationOptions = [
        { label: 'B.E/B.Tech', value: 'B.E/B.Tech' },
        { label: 'M.Tech/MBA', value: 'M.Tech/MBA' },
        { label: 'Ph.d', value: 'Ph.d' },
        { label: 'Post Doc', value: 'Post Doc' },
        // Add more options as needed
    ];

    handleEducationChange(event) {
        this.education = event.detail.value;
    }

    handleSearch() {
        searchCandidatesByEducation({ education: this.education })
        .then(result => {
            this.searchResults = result;
        })
        .catch(error => {
            // Handle error, e.g., display an error message
        });
    }

    viewCandidateDetails(event) {
        const candidateId = event.currentTarget.dataset.id;
        // Use the NavigationMixin to navigate to the candidate's record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: candidateId,
                actionName: 'view'
            }
        });
    }
}