import { LightningElement } from 'lwc';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import CANDIDATE_OBJECT from '@salesforce/schema/Candidate__c';

import Candidate_Name from '@salesforce/schema/Candidate__c.Name';
import Email from '@salesforce/schema/Candidate__c.Email__c';


import Education from '@salesforce/schema/Candidate__c.Education__c';
import Phone from '@salesforce/schema/Candidate__c.Phone__c';

import Experience_In_years from '@salesforce/schema/Candidate__c.Experience_In_years__c';


import User from '@salesforce/schema/Candidate__c.User__c';




 

 



 

 

export default class createCandidateRecord extends NavigationMixin(LightningElement) {

    objectApiName=CANDIDATE_OBJECT;

    fields = [Candidate_Name,Email,Phone,Education,Experience_In_years,User
];

 

    handleSuccess(event){

        const toastEvent=new ShowToastEvent({

            title:"Candidate Record Created !",

            message: "Record Creation Successful",

            variant: "success"

        });
        this[NavigationMixin.Navigate]({

            type: 'standard__objectPage',

            attributes: {

                objectApiName: 'Candidate__c',

                actionName: 'list'

            }

        });

        this.dispatchEvent(toastEvent);

    }
    handleCancel() {

        // Use the NavigationMixin to navigate to a different page (e.g., the list view)

        this[NavigationMixin.Navigate]({

            type: 'standard__objectPage',

            attributes: {

                objectApiName: 'Candidate__c',

                actionName: 'list'

            }

        });
        

    }

}