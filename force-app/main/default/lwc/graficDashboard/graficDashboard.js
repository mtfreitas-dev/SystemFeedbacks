import { LightningElement, api } from 'lwc';
import chartJs from '@salesforce/resourceUrl/chartJs';
import { loadScript } from 'lightning/platformResourceLoader';
import getFeedbacksData from '@salesforce/apex/controller.getFeedbacksData';

export default class GraficDashboard extends LightningElement {

    chart;
    data;
    carregouJs = false;
    //@api dados;

    @api set dados(dados) {
        if (this.chart) {
            this.chart.destroy();
        }
        //
        this.data = dados ? Object.values(dados) : [0, 0, 0, 0, 0];

        if(this.carregouJs == true){
            this.renderChart(this.data);
        }
    };

    get dados() {
        this.data;
    }

    renderedCallback() {
        if(!this.carregouJs){
            this.carregarScript();
        }
    }

    carregarScript() {
        loadScript(this, chartJs)
            .then(() => {
                this.loadData();
                this.carregouJs = true;
            })
    }

    loadData() {
        getFeedbacksData()
            .then(data => {
                this.data = Object.values(data);
                this.renderChart(this.data);
            })
            .catch(error => {
                console.log('Error ' + error);
            })
    }

    renderChart(data) {
        const ctx = this.template.querySelector('canvas').getContext('2d');
        this.chart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['⭐1', '⭐2', '⭐3', '⭐4', '⭐5'],
                datasets: [{
                    data: data,
                    backgroundColor: ['#6A4C93', '#8E6CAB', '#7B6CF0', '#5A67D8', '#4C73D9']
                }]
            }
        });
    }
}
