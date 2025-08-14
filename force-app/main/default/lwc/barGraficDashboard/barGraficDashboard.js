import { LightningElement } from 'lwc';
import chartJs from '@salesforce/resourceUrl/chartJs';
import { loadScript } from 'lightning/platformResourceLoader';
import getSentimentData from '@salesforce/apex/controller.getSentimentData'

export default class barGraficDashboard extends LightningElement {

    chart;

    data;

    renderedCallback(){
        this.loadData();
    }

    loadData(){
        getSentimentData()
        .then(data => {
            this.data = Object.values(data);
            console.log('Data ', this.data);
            this.renderChart(this.data);
        });
    }

    renderChart() {
        if(this.data != null) {
            loadScript(this, chartJs)
            .then(() => {
                const ctx = this.template.querySelector('canvas').getContext('2d');
                this.chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ['Negative', 'Neutre', 'Positive'],
                        datasets: [{
                            data: this.data,
                            backgroundColor: ['#19144eff', '#680f8eff', '#5b0b61ff', '#0b5e61ff']
                        }]
                    }
                })
            }
            )
        }
    }
}
