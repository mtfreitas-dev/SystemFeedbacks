import { LightningElement, api } from 'lwc';

export default class FilterDashboard extends LightningElement {

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

    handleChangePeriod(event){
        this.value = event.detail.value;
        window.alert('You have selected this value: ' + this.value);
    }

    handleChangeCategory(event){
        this.valueCategory = event.detail.value;
        window.alert('You have selected this value: ' + this.valueCategory);
    }
}