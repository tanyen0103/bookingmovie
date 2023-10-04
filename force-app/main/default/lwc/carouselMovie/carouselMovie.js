import { LightningElement, api, wire } from 'lwc';
import getMovies from '@salesforce/apex/MovieController.getMovies';

export default class CarouselMovie extends LightningElement {
    @wire(getMovies)
    movies
}