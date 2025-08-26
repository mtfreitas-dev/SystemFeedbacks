import { LightningElement } from 'lwc';
import getDataGraficBar from '@salesforce/apex/controller.getDataGraficBar';
import getDataFraficDonut from '@salesforce/apex/controller.getDataFraficDonut'

export default class FeedbackDashboard extends LightningElement {

    filtrar = false;
    period;
    category = [];
    barGraficdata;
    barDonutGrafic;

    handleFiltrar(event){
        if(this.filtrar == true){
            this.filtrar = false;
        }else{
            this.filtrar = true;
        }

        this.period = event.detail.period;
        this.category = event.detail.category;
        this.loadData();
    }

    getData(event) {
    this.period = event.detail.period;
    this.category = event.detail.category;

    // Mostrar valores
    console.log('Categorias (spread): ', [...this.category]);
    console.log('Categorias (JSON): ', JSON.stringify(this.category));

    this.loadData();    
}

    loadData(){
        getDataGraficBar({days: this.period, category: this.category})
        .then(data => {
            this.barGraficdata = Object.values(data);
            console.log('Dado recebido', data);
        })
        .catch(error => {
            console.log('Erro ao carregar dados', error);
        })

        getDataFraficDonut({days: this.period, category: this.category})
        .then(data => {
            this.barDonutGrafic = data;
            console.log('Recebendo dado: ', data);
        })
        .catch(error => {
            console.log('Erro ao carregar dados', error);
        })
        
    }
}