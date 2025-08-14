import { LightningElement, wire } from 'lwc';
import getFeedbacks from '@salesforce/apex/controller.getFeedbacks';

export default class FeedbackTable extends LightningElement {

    feedbacks;

    renderedCallback() {
    if (!this.rendered) {
        this.rendered = true;
        this.loadData();
    }
}

    loadData() {
        getFeedbacks()
            .then(data => {
                this.feedbacks = data;
            })
            .catch(error => {
                console.error('Error', error);
            });
    }
} 