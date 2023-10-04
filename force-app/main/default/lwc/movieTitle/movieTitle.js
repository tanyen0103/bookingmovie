import { LightningElement, api } from 'lwc';

export default class MovieTitle extends LightningElement {
    @api movie;

    handleOpenRecordClick() {
	const selectEvent = new CustomEvent('movieview', {
		detail: this.movie.Id
	});
        this.dispatchEvent(selectEvent);
        console.log(selectEvent);
}
}