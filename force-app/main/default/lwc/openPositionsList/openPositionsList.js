import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getOpenPositions from '@salesforce/apex/PositionController.getOpenPositions';

const columns = [
    { label: 'Position Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Close Date', fieldName: 'Close_Date__c', type: 'date', sortable: true },
];

export default class OpenPositionsList extends NavigationMixin(LightningElement) {
    positionData;
    columns = columns;

    @wire(getOpenPositions)
    wiredPositions({ error, data }) {
        if (data) {
            this.positionData = data.map((position) => ({
                ...position,
                recordUrl: `/${position.Id}`, // Create a record URL for each record
            }));
        } else if (error) {
            // Handle error
        }
    }

    handleRowClick(event) {
        const recordId = event.detail.row.Id;
        
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view',
            },
        });
    }
}