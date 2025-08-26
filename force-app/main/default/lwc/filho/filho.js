import { LightningElement, api } from 'lwc';

export default class Filho extends LightningElement {
    @api message;
    teste = 'Primeira mensagem';

    valuePeriod;
    valueCategory;

    periodOption = [
        { label: 'Últimos 7 dias', value: '7' },
        { label: 'Últimos 30 dias', value: '30' },
        { label: 'Últimos 90 dias', value: '90' }
    ];

    categoryOption = [
        { label: 'Product', value: 'Product'},
        { label: 'Support', value: 'Support'},
        { label: 'Delivery', value: 'Delivery'}
    ]

    enviarMensagem(){
        this.dispatchEvent(new CustomEvent('filtrar', {detail: {
            period: this.valuePeriod,
            category: this.valueCategory
        }}))
    }

    handleChangeCategory(event){
        this.valueCategory = event.detail.value;
    }

    handleChangePeriod(event){
        this.valuePeriod = event.detail.value;
    }
}