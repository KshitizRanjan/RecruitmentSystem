import { LightningElement } from 'lwc';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import POSITION_OBJECT from '@salesforce/schema/Position__c';

import Position_Name from '@salesforce/schema/Position__c.Name';
import Skills_Required from '@salesforce/schema/Position__c.Skills_Required__c';

import Minimum_Pay from '@salesforce/schema/Position__c.Minimum_Pay__c';

import Maximum_Pay from '@salesforce/schema/Position__c.Maximum_Pay__c';

import Responsibilities from '@salesforce/schema/Position__c.Responsibilities__c';

import Educational_Requirement from '@salesforce/schema/Position__c.Educational_Requirement__c';

import Close_Date from '@salesforce/schema/Position__c.Close_Date__c';

import No_Of_Openings from '@salesforce/schema/Position__c.No_of_Openings__c';





 

 



 

 

export default class createPositionRecord extends NavigationMixin(LightningElement) {

    objectApiName=POSITION_OBJECT;

    fields = [Position_Name,Close_Date,No_Of_Openings,Skills_Required,Responsibilities,Educational_Requirement,Minimum_Pay,Maximum_Pay
];

 

    handleSuccess(event){

        const toastEvent=new ShowToastEvent({

            title:"Position Created !",

            message: "Position has been created.",

            variant: "success"

        });
        this[NavigationMixin.Navigate]({

            type: 'standard__objectPage',

            attributes: {

                objectApiName: 'Position__c',

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

                objectApiName: 'Position__c',

                actionName: 'list'

            }

        });
        

    }


}