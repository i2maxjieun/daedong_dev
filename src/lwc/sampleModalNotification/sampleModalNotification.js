/**
 * Created by ms on 2022-07-13.
 */

import LwcComBase from "c/lwcComBase";

export default class SampleModalNotification extends LwcComBase {
    confirmStatus;
    promptValue;

    handleAlertClick() {
        this.gfn_Alert('Alert Header', 'Alert Message', 'info');
    }

    handleConfirmClick(){
        this.gfn_Confirm('Confirm Header','Confirm Message','headerless')
            .then(result => {
                if(result){
                    this.confirmStatus = 'Ok 클릭';
                }else{
                    this.confirmStatus = 'Cancel 클릭';
                }
            });
    }

    handlePromptClick() {
        this.gfn_Prompt('Prompt Header','Prompt Message','Response Value.','shade')
            .then(result => {
                this.promptValue = result;
            })
    }
}