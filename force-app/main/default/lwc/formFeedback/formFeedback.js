import { LightningElement } from 'lwc';

export default class FormFeedback extends LightningElement {
    create = true;

    handleSubmit(){
        this.create = false;
        window.alert('Feedback enviado com sucesso!');
    }
}