import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFiel } from 'lightning/uiRecordApi';
// Membership Object 

//Current User
import Id from "@salesforce/user/Id";
import USER_NAME_FIELD from '@salesforce/schema/User.Name';

import getMemberships from '@salesforce/apex/MembershipController.getMemberships';

export default class MemberInfor extends LightningElement {
    name;
    rank;
    address;
    email;

    @wire(getMemberships)
    wiredRecord({ error, data }) {
        if (data) {
        console.log(data);
        this.name = data.Name;
        this.rank = data.Rank__c;
        this.address = data.Address__c;
        this.email = data.Email__c;
    }
  }


    

}