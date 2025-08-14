import { LightningElement, wire } from 'lwc';
import chartJs from '@salesforce/resourceUrl/chartJs';
import { loadScript } from 'lightning/platformResourceLoader';
import getFeedbacksData from '@salesforce/apex/controller.getFeedbacksData';

export default class GraficDashboard extends LightningElement {

    chart;

    data;
    realData;

    renderedCallback(){
        this.loadData();
    }

    loadData(){
        getFeedbacksData()
        .then(data => {
            this.data = Object.values(data);
            this.renderChart(this.data);
            console.log('Dados Sf', this.data);
         })
        .catch(error => {
            console.log('Error ' + error);
        })
    }

    renderChart(data) {
        loadScript(this, chartJs)
            .then(() => {
                const ctx = this.template.querySelector('canvas').getContext('2d');
                this.chart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: ['⭐1','⭐2','⭐3','⭐4','⭐5'],
                        datasets: [{
                            data: this.data,
                            backgroundColor: ['#5372d4ff', '#36ebe2ff', '#9ed3d4ff','#430d8aff', '#9315dbff']
                        }]
                    }
                });
            });
    }
}


    
    /*@wire(getFeedbacksData)
    feedbacks({ data }){
        if(data){
            //this.renderChart(Object.values(data));
            console.log('Data ' + data);
        }
    }
        
    renderedCallback() {
        if (this.chart) return; // evita criar várias vezes

        loadScript(this, chartJs);
    } */ 
