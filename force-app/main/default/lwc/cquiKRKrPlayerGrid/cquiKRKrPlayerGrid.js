import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_KR_SQX_PLAYER__C from '@salesforce/schema/CQ_KR_SQX_Player__c';


import FIELDS_PARENT_ID from '@salesforce/schema/CQ_KR_SQX_Coach__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/CQ_KR_SQX_Coach__c.Name';

import FIELDS_PARENT_CQ_KR_TRAINING_STATUS__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Training_Status__c';





//import fields


import FIELDS_CQ_KR_SQX_PLAYER__C_NAME from '@salesforce/schema/CQ_KR_SQX_Player__c.Name';

import FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_TEAM__C from '@salesforce/schema/CQ_KR_SQX_Player__c.CQ_KR_Team__c';

import FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__C from '@salesforce/schema/CQ_KR_SQX_Player__c.CQ_KR_SQX_Coach__c';

import FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__R_NAME from '@salesforce/schema/CQ_KR_SQX_Player__c.CQ_KR_SQX_Coach__r.Name';

import FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__R_CQ_KR_TRAINING_STATUS__C from '@salesforce/schema/CQ_KR_SQX_Player__c.CQ_KR_SQX_Coach__r.CQ_KR_Training_Status__c';

import FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_JOINING_DATE__C from '@salesforce/schema/CQ_KR_SQX_Player__c.CQ_KR_Joining_Date__c';


//import customlabels (Labels must not have space)

import CQKR_NEW from '@salesforce/label/c.CQKR_NEW';

import CQKR_BULK_EDIT from '@salesforce/label/c.CQKR_BULK_EDIT';




            
import CQKR_COMBFIELD from '@salesforce/label/c.CQKR_COMBFIELD';
            

//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_KR_SQX_PLAYER__C_NAME,

        
    FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_TEAM__C,

        
    FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__C,
                
            
               
              {
                
                    label: CQKR_COMBFIELD,
                
                
                    type:'customComponent',
                
                

                    fields:[
                    
                    
                        {
                            fieldInfo:FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__C
                            
                            ,displayField:FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__R_CQ_KR_TRAINING_STATUS__C
                            
                            
                            ,displayType:'hyperLink'
                            
                            
                        },
                        
                        {
                            fieldInfo:FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_JOINING_DATE__C
                            
                            
                            
                        },
                        
                    ],
                

                
                    groupName:'combfieldGroup'
                

               },
          
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

    FIELDS_PARENT_CQ_KR_TRAINING_STATUS__C,

];

export default class cquiKRKrPlayerGrid  extends CqGridForm {
    @api
    maxRows;

    @api
    maxColumns;

    @api
    gridType;

    @api
    flexipageRegionWidth;
    
    constructor() {
        super();
        this.fields = columns;
        this.columns = columns;
        this.mainObject = CQ_KR_SQX_PLAYER__C;
        this.relationalField = FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQKR_NEW,"name":"std_new","componentName":"cqui-k-r-kr-player-both"},{"label": CQKR_BULK_EDIT,"name":"showEditSelected","componentName":"cqui-k-r-kr-player-both","component_namespace":"c-","action_type":"","bulk":true},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"edit":{"fields":["CQ_KR_Training_Status__c","CQ_KR_Training_Status__c"],"visible":"parent.CQ_KR_Training_Status__c.value == 'Draft'   || parent.CQ_KR_Training_Status__c.value == 'In progress'  "},"delete":{"fields":["CQ_KR_Training_Status__c","CQ_KR_Training_Status__c"],"visible":"parent.CQ_KR_Training_Status__c.value == 'Draft'   || parent.CQ_KR_Training_Status__c.value == 'In progress'  "}};
        

        
        this.headerFormRules = {"std_new":{"fields":["CQ_KR_Training_Status__c","CQ_KR_Training_Status__c"],"visible":"parent.CQ_KR_Training_Status__c.value == 'Draft'   || parent.CQ_KR_Training_Status__c.value == 'In progress'  "},"showEditSelected":{"fields":["CQ_KR_Training_Status__c","CQ_KR_Training_Status__c"],"visible":"parent.CQ_KR_Training_Status__c.value == 'Draft'   || parent.CQ_KR_Training_Status__c.value == 'In progress'  "}};
        

        
        
    
        this.lookupFields[FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__C.fieldApiName] = FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__R_NAME;
                
                
            
               
                   
        this.lookupFields[FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__C.fieldApiName]=FIELDS_CQ_KR_SQX_PLAYER__C_CQ_KR_SQX_COACH__R_CQ_KR_TRAINING_STATUS__C;
                   

             
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiKRKrPlayerGrid";

    }

    connectedCallback(){
        this.maxRowsToDisplay = this.maxRows;
        this.maxColumnsToDisplay = this.maxColumns;
        this.gridDesktopView = this.gridType;
    }

    @api 
    get recordId() {
        return this._recordId;
    }

    set recordId(value) {
        this._recordId = value;
    }

}