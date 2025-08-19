import { LightningElement, api, track } from 'lwc';
import chartJs from '@salesforce/resourceUrl/chartJs';
import { loadScript } from 'lightning/platformResourceLoader';
import getSentimentData from '@salesforce/apex/controller.getSentimentData';

export default class BarGraficDashboard extends LightningElement {
    chart;
    @track chartJsInitialized = false;
    @track data = [0, 0, 0]; // Valores padrão
    @track error;

    @api 
    set filterdata(data){
        if(this.chart) {
            this.chart.destroy();
        }
        
        // Verifica se data é válido antes de converter
        this.data = data ? Object.values(data) : [0, 0, 0];
        
        if(this.chartJsInitialized) {
            this.renderChart();
        }
    }
    
    get filterdata() {
        return this.data;
    }

    renderedCallback() {
        if(!this.chartJsInitialized) {
            this.initializeChartJs();
        }
    }

    initializeChartJs() {
        loadScript(this, chartJs)
        .then(() => {
            this.chartJsInitialized = true;
            this.loadData();
        })
        .catch(error => {
            this.error = error;
            console.error('Erro ao carregar Chart.js', error);
        });
    }

    loadData() {
        getSentimentData()
            .then(data => {
                // Adicionada verificação para dados nulos
                this.data = data ? Object.values(data) : [0, 0, 0];
                this.renderChart();
            })
            .catch(error => {
                this.error = error;
                console.error('Erro ao carregar dados', error);
                // Define valores padrão em caso de erro
                this.data = [0, 0, 0];
                this.renderChart();
            });
    }

    renderChart() {
        if(!this.chartJsInitialized || !this.data) return;
        
        const ctx = this.template.querySelector('canvas')?.getContext('2d');
        if(!ctx) return; // Verifica se o canvas existe
        
        if(this.chart) {
            this.chart.destroy();
        }
        
        this.chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Negative', 'Neutre', 'Positive'],
                datasets: [{
                    data: this.data,
                    backgroundColor: ['#19144eff', '#680f8eff', '#5b0b61ff', '#0b5e61ff']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
    }
}