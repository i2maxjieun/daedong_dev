/**
 * Created by ms on 2022-07-25.
 */

import {api, wire} from 'lwc';
import LwcComBase from "c/lwcComBase";
import callInterFace from '@salesforce/apex/AccountService.callInterFace';

export default class CallInterFace extends LwcComBase {
    @api recordId;
    accountId;
    response;

    renderedCallback() {
        if(this.recordId != null && this.recordId != undefined){
            this.accountId = this.recordId;
        }
    }

    @wire(callInterFace, {accountId: '$accountId'})
    wiredGetRecords({data, error}){
        if(data){
            this.response = data.MESSAGE;
        }else if(error){
            this.gfn_ApexErrorHandle(error);
        }
    };

    handleClose(){
        this.gfn_QaClose();
    }
}