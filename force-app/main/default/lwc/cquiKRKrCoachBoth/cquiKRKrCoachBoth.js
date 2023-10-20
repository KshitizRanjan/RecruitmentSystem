// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_KR_SQX_COACH__C from '@salesforce/schema/CQ_KR_SQX_Coach__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/CQ_KR_SQX_Coach__c.Name';

import FIELD_OWNERID from '@salesforce/schema/CQ_KR_SQX_Coach__c.OwnerId';

import FIELD_CQ_KR_SQX_ACCOUNT__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_Account__c';

import FIELD_CQ_KR_SQX_PART_FAMILY__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_Part_Family__c';

import FIELD_CQ_KR_SQX_PART__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_Part__c';

import FIELD_CQ_KR_TEAM__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Team__c';

import FIELD_CQ_KR_TITLE__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Title__c';

import FIELD_CQ_KR_DESCRIPTION__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Description__c';

import FIELD_CQ_KR_TRAINING_COMPLETION_DATE__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Training_Completion_Date__c';

import FIELD_CQ_KR_TRAINING_START_DATE__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Training_Start_Date__c';

import FIELD_CQ_KR_SQX_USER__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_User__c';

import FIELD_CQ_KR_WORKING_DAYS__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Working_Days__c';

import FIELD_CQ_KR_TRAINING_STATUS__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Training_Status__c';

import FIELD_CQ_KR_RESUME__C from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_Resume__c';

import FIELD_CREATEDBYID from '@salesforce/schema/CQ_KR_SQX_Coach__c.CreatedById';

import FIELD_LASTMODIFIEDBYID from '@salesforce/schema/CQ_KR_SQX_Coach__c.LastModifiedById';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    
import FIELD_CQ_KR_SQX_ACCOUNT__NAME from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_Account__r.Name';
    


    
import FIELD_CQ_KR_SQX_PART_FAMILY__NAME from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_Part_Family__r.Name';
    


    
import FIELD_CQ_KR_SQX_PART__NAME from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_Part__r.Name';
    


    


    


    


    


    


    
import FIELD_CQ_KR_SQX_USER__NAME from '@salesforce/schema/CQ_KR_SQX_Coach__c.CQ_KR_SQX_User__r.Name';
    


    


    


    


    


    



// import section custom label
    
        
import CQKR_INFORMATION from '@salesforce/label/c.CQKR_INFORMATION';
        
    
        
import CQKR_SYSTEM_INFORMATION from '@salesforce/label/c.CQKR_SYSTEM_INFORMATION';
        
    
        
import CQKR_CUSTOM_LINKS from '@salesforce/label/c.CQKR_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_OWNERID,
    
    FIELD_CQ_KR_SQX_ACCOUNT__C,
    
    FIELD_CQ_KR_SQX_PART_FAMILY__C,
    
    FIELD_CQ_KR_SQX_PART__C,
    
    FIELD_CQ_KR_TEAM__C,
    
    FIELD_CQ_KR_TITLE__C,
    
    FIELD_CQ_KR_DESCRIPTION__C,
    
    FIELD_CQ_KR_TRAINING_COMPLETION_DATE__C,
    
    FIELD_CQ_KR_TRAINING_START_DATE__C,
    
    FIELD_CQ_KR_SQX_USER__C,
    
    FIELD_CQ_KR_WORKING_DAYS__C,
    
    FIELD_CQ_KR_TRAINING_STATUS__C,
    
    FIELD_CQ_KR_RESUME__C,
    
    FIELD_CREATEDBYID,
    
    FIELD_LASTMODIFIEDBYID,
    
    
    
        
    
        
    
        
    FIELD_CQ_KR_SQX_ACCOUNT__NAME,
        
    
        
    FIELD_CQ_KR_SQX_PART_FAMILY__NAME,
        
    
        
    FIELD_CQ_KR_SQX_PART__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
        
    FIELD_CQ_KR_SQX_USER__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        
    "CQ_KR_SQX_Account__c": FIELD_CQ_KR_SQX_ACCOUNT__NAME,
    

        
    "CQ_KR_SQX_Part_Family__c": FIELD_CQ_KR_SQX_PART_FAMILY__NAME,
    

        
    "CQ_KR_SQX_Part__c": FIELD_CQ_KR_SQX_PART__NAME,
    

        

        

        

        

        

        
    "CQ_KR_SQX_User__c": FIELD_CQ_KR_SQX_USER__NAME,
    

        

        

        

        

        

};

const LOOKUP_FILTERS = {"CQ_KR_SQX_Account__c":{"filters":[{"field":"RecordTypeId","usv_function":"reference","operator":"eq","isDynamic":false,"usv_param":"Name","value":"Supplier"},{"field":"compliancequest__Active__c","operator":"eq","value":"Yes"}],"logic":"and"},"CQ_KR_SQX_Part__c":{"fields":["CQ_KR_SQX_Part_Family__c"]}};
const DYNAMIC_SOURCES = {"CQ_KR_SQX_Part__c":{"ns":"","componentname":"CQUI_KR_Filter_Products_By_ProductFamily"}};
const FORM_RULES = {"CQ_KR_Description__c":{"hidden":{"fields":["CQ_KR_Team__c"],"filter":"record.CQ_KR_Team__c == 'None' "}},"CQ_KR_Training_Completion_Date__c":{"invoke":{"fields":["CQ_KR_Training_Completion_Date__c"],"filter":"true","action":[{"name":"CQUI_KR_TargetCompletionDate_AL_Flow","ns":""}]}},"onLoad":{"invoke":{"action":[{"name":"CQUI_KR_TargetCompletionDate_AL_Flow","ns":""}]}},"CQ_KR_SQX_Account__c":{"transfer":[{"fields":["CQ_KR_SQX_Account__c"],"filter":"record.CQ_KR_SQX_Account__c   ","action":{"OwnerId":["CQ_KR_SQX_User__c"],"Owner":["CQ_KR_SQX_User__r"]}}]},"CQ_KR_SQX_User__c":{"readonly":{"fields":["CQ_KR_Training_Completion_Date__c"],"filter":"record.CQ_KR_Training_Completion_Date__c   "}},"Resume__c":{"required":{"fields":["CQ_KR_Team__c"],"filter":"record.CQ_KR_Team__c != 'None' "}},"CQ_KR_Title__c":{"required":{"fields":["CQ_KR_Team__c"],"filter":"record.CQ_KR_Team__c != 'None' "}},"CQ_KR_Resume__c":{"required":{"fields":["CQ_KR_Team__c"],"filter":"record.CQ_KR_Team__c != 'None' "}}};
const FORMULA_FIELDS = {};

export default class cquiKRKrCoachBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_KR_SQX_COACH__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {"CQ_KR_Resume__c":{"type":"file","showFilePicker":true,"shareContent":true}};
        this.parentRecordApi="";
        
    }


    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        this._recordId = value;
        this.parentId = value;
    }

    // getters for field value, display value and field metadata
    
    get v_NAME() {
        return this.getValueFor(FIELD_NAME.fieldApiName);
    }
    get f_NAME() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_NAME.fieldApiName] : {};
        return val;
    }

    get d_NAME() {
        return lookupDisplayFields[FIELD_NAME.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_NAME.fieldApiName].fieldApiName);
    }

    
    get v_OWNERID() {
        return this.getValueFor(FIELD_OWNERID.fieldApiName);
    }
    get f_OWNERID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_OWNERID.fieldApiName] : {};
        return val;
    }

    get d_OWNERID() {
        return lookupDisplayFields[FIELD_OWNERID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_OWNERID.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_SQX_ACCOUNT__C() {
        return this.getValueFor(FIELD_CQ_KR_SQX_ACCOUNT__C.fieldApiName);
    }
    get f_CQ_KR_SQX_ACCOUNT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_SQX_ACCOUNT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_SQX_ACCOUNT__C() {
        return lookupDisplayFields[FIELD_CQ_KR_SQX_ACCOUNT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_SQX_ACCOUNT__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_SQX_PART_FAMILY__C() {
        return this.getValueFor(FIELD_CQ_KR_SQX_PART_FAMILY__C.fieldApiName);
    }
    get f_CQ_KR_SQX_PART_FAMILY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_SQX_PART_FAMILY__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_SQX_PART_FAMILY__C() {
        return lookupDisplayFields[FIELD_CQ_KR_SQX_PART_FAMILY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_SQX_PART_FAMILY__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_SQX_PART__C() {
        return this.getValueFor(FIELD_CQ_KR_SQX_PART__C.fieldApiName);
    }
    get f_CQ_KR_SQX_PART__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_SQX_PART__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_SQX_PART__C() {
        return lookupDisplayFields[FIELD_CQ_KR_SQX_PART__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_SQX_PART__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_TEAM__C() {
        return this.getValueFor(FIELD_CQ_KR_TEAM__C.fieldApiName);
    }
    get f_CQ_KR_TEAM__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_TEAM__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_TEAM__C() {
        return lookupDisplayFields[FIELD_CQ_KR_TEAM__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_TEAM__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_TITLE__C() {
        return this.getValueFor(FIELD_CQ_KR_TITLE__C.fieldApiName);
    }
    get f_CQ_KR_TITLE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_TITLE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_TITLE__C() {
        return lookupDisplayFields[FIELD_CQ_KR_TITLE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_TITLE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_DESCRIPTION__C() {
        return this.getValueFor(FIELD_CQ_KR_DESCRIPTION__C.fieldApiName);
    }
    get f_CQ_KR_DESCRIPTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_DESCRIPTION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_DESCRIPTION__C() {
        return lookupDisplayFields[FIELD_CQ_KR_DESCRIPTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_DESCRIPTION__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_TRAINING_COMPLETION_DATE__C() {
        return this.getValueFor(FIELD_CQ_KR_TRAINING_COMPLETION_DATE__C.fieldApiName);
    }
    get f_CQ_KR_TRAINING_COMPLETION_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_TRAINING_COMPLETION_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_TRAINING_COMPLETION_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_KR_TRAINING_COMPLETION_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_TRAINING_COMPLETION_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_TRAINING_START_DATE__C() {
        return this.getValueFor(FIELD_CQ_KR_TRAINING_START_DATE__C.fieldApiName);
    }
    get f_CQ_KR_TRAINING_START_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_TRAINING_START_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_TRAINING_START_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_KR_TRAINING_START_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_TRAINING_START_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_SQX_USER__C() {
        return this.getValueFor(FIELD_CQ_KR_SQX_USER__C.fieldApiName);
    }
    get f_CQ_KR_SQX_USER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_SQX_USER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_SQX_USER__C() {
        return lookupDisplayFields[FIELD_CQ_KR_SQX_USER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_SQX_USER__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_WORKING_DAYS__C() {
        return this.getValueFor(FIELD_CQ_KR_WORKING_DAYS__C.fieldApiName);
    }
    get f_CQ_KR_WORKING_DAYS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_WORKING_DAYS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_WORKING_DAYS__C() {
        return lookupDisplayFields[FIELD_CQ_KR_WORKING_DAYS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_WORKING_DAYS__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_TRAINING_STATUS__C() {
        return this.getValueFor(FIELD_CQ_KR_TRAINING_STATUS__C.fieldApiName);
    }
    get f_CQ_KR_TRAINING_STATUS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_TRAINING_STATUS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_TRAINING_STATUS__C() {
        return lookupDisplayFields[FIELD_CQ_KR_TRAINING_STATUS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_TRAINING_STATUS__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_KR_RESUME__C() {
        return this.getValueFor(FIELD_CQ_KR_RESUME__C.fieldApiName);
    }
    get f_CQ_KR_RESUME__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_KR_RESUME__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_KR_RESUME__C() {
        return lookupDisplayFields[FIELD_CQ_KR_RESUME__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_KR_RESUME__C.fieldApiName].fieldApiName);
    }

    
    get v_CREATEDBYID() {
        return this.getValueFor(FIELD_CREATEDBYID.fieldApiName);
    }
    get f_CREATEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CREATEDBYID.fieldApiName] : {};
        return val;
    }

    get d_CREATEDBYID() {
        return lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName].fieldApiName);
    }

    
    get v_LASTMODIFIEDBYID() {
        return this.getValueFor(FIELD_LASTMODIFIEDBYID.fieldApiName);
    }
    get f_LASTMODIFIEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_LASTMODIFIEDBYID.fieldApiName] : {};
        return val;
    }

    get d_LASTMODIFIEDBYID() {
        return lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName].fieldApiName);
    }

    


    
        
    get CQKR_INFORMATION() {
        return CQKR_INFORMATION;
    }
        
    
        
    get CQKR_SYSTEM_INFORMATION() {
        return CQKR_SYSTEM_INFORMATION;
    }
        
    
        
    get CQKR_CUSTOM_LINKS() {
        return CQKR_CUSTOM_LINKS;
    }
        
    
}