import { LightningElement } from 'lwc';
import getData from '@salesforce/apex/controller.getData';

export default class FeedbackDashboard extends LightningElement {

    filtrar = false;
    period;
    category;
    barGraficdata;
    barDonutGrafic

    handleFiltrar(){
        if(this.filtrar == true){
            this.filtrar = false;
        }else{
            this.filtrar = true;
        }
    }

    getData(event){
        console.log('Período ', event.detail.period );
        this.period = event.detail.period
        console.log('Categoria ', event.detail.category);
        this.category = event.detail.category;
        this.loadData();    
    }

    loadData(){
        getData({days: this.period})
        .then(data => {
            this.barGraficdata = Object.values(data);
            console.log('Dado recebido', data);
        })
    }

    /*
    }*/
}