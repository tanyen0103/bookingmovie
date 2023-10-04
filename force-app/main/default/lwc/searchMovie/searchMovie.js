import { LightningElement, wire } from 'lwc';
import searchMovies from '@salesforce/apex/MovieController.searchMovies';

import { NavigationMixin } from 'lightning/navigation';

export default class SearchMovie extends NavigationMixin(LightningElement) {
    searchKey = "";
    startDate
    endDate
    errorDate

    @wire(searchMovies, { searchKey: "$searchKey" })
    movies;
    

    handleSearchKeyChange(event) {
         window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
        this.searchKey = searchKey;
        }, 300);
    }

    handleDateChange(event) {
        const { name, value } = event.target;
        this[name] = value;
        if (name === 'startDate') {
            console.log(this.startDate);
        }
        if (name === 'endDate') {
            console.log(this.endDate);
        }
    }

    handleSearchClick() {
        if (this.validateDate(this.startDate, this.endDate)) {
            this.errorDate = `You can only choose a  end date within 7 days from ${this.startDate}`;
        } else {
            console.log('Data valid');
        }
    }

    validateDate(startDate, endDate) { 
        return new Date(startDate).getTime() <= new Date(endDate).getTime() - (7 * 24 * 60 * 60 * 1000);
    }

    get hasResults() {
        return this.movies.data.length > 0;
    }

    handleMovieView(event) {
		// Get movie record id from movieview event
		const movieId = event.detail;
		// Navigate to movie record page
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: movieId,
				objectApiName: 'Movie__c',
				actionName: 'view',
			},
		});
    }

    
    
}