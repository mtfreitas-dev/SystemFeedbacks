import { LightningElement } from 'lwc';

export default class FeedbackDashboard extends LightningElement {

    filtrar = false;

    handleFiltrar(){
        if(this.filtrar == true){
            this.filtrar = false;
        }else{
            this.filtrar = true;
        }
    }
}