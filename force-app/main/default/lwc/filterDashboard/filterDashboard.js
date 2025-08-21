import { LightningElement, api } from 'lwc';

export default class FilterDashboard extends LightningElement {

    valuePeriod;
    valueCategory = [];
    check;


    periodOption = [
        { label: 'Últimos 7 dias', value: '7' },
        { label: 'Últimos 30 dias', value: '30' },
        { label: 'Últimos 90 dias', value: '90' },
        {label: 'Sem filtro', value: null}
    ];


    get options(){
        return [
            { label: 'Product', value: 'Product' },
            { label: 'Support', value: 'Support' },
            { label: 'Delivery', value: 'Delivery' }
        ]
    }


    handleChangePeriod(event) {
        this.valuePeriod = event.detail.value;
        console.log('SELECIONANDO PERIODO ', this.valuePeriod);
    }

    handleChangeCategory(event) {
        this.valueCategory = event.detail.value;
        console.log('SELECIONANDO CATEGORIA ', this.valueCategory);
    }

    sendData() {
        this.dispatchEvent(new CustomEvent('filtrar', {
            detail: {
                period: this.valuePeriod,
                category: this.valueCategory
            }
        }))
    }

    handleCancel() {
        this.check = true;
        this.valueCategory = null;
        this.period = null;

        this.dispatchEvent(new CustomEvent('cancel', {
            detail: {
                check: this.check,
                period: this.valuePeriod,
                category: this.valueCategory
            }
        }))
    }
}