import { LightningElement } from 'lwc';
import teste from '@salesforce/apex/controller.teste';

export default class pai extends LightningElement {

    periodo;
    categoria;

    messaggemEnviar;

    handleChange(event){
        this.messaggemEnviar = event.target.value;
        console.log(this.messaggemEnviar);
    }

    receberMensagem(event) {
       this.periodo = event.detail.period;
       this.categoria = event.detail.category;

       this.messaggemEnviar = `Periodo: ${this.periodo} - Categoria: ${this.categoria}`;

       teste()
       .then(data => {
        console.log('Dado recebido: ', data); 
       })
    }

    
}