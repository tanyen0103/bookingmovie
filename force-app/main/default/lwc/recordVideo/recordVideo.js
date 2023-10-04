import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import TITLE_FILED from '@salesforce/schema/Movie__c.Title__c';
import VIDEO_URL_FIELD from '@salesforce/schema/Movie__c.video_URL__c';
import PICTURE_URL_FIELD from '@salesforce/schema/Movie__c.picture_URL__c';

const movieFields = [
    TITLE_FILED,
    VIDEO_URL_FIELD,
    PICTURE_URL_FIELD
];

export default class RecordVideo extends LightningElement {
    @api recordId;
    title;
    videoURL;
    pictureURL
    @wire(getRecord, { recordId: '$recordId', fields: movieFields })
    loadMovie({ data, error }) {
        if (error) { 

        } else if (data) {
            this.title = getFieldValue(data, TITLE_FILED);
            this.videoURL = getFieldValue(data, VIDEO_URL_FIELD);
            this.pictureURL = getFieldValue(data, PICTURE_URL_FIELD);
            console.log(this.videoURL);
        }
    }

    handleClick() {
        if (this.videoURL) {
            window.open(this.videoURL, '_blank');
        }
    }

}