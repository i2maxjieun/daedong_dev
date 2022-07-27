/**
 * Created by ms on 2022-07-22.
 */

public with sharing class AccountService {

    public static Map<String, String> IF_KR_SE_HEROKU_0001(String recordId) {

        Map<String, String> returnMap = new Map<String, String>();
        //인터페이스 데이터 취득
        List<Contact> inputContacts = [
                SELECT  Id,
                        Name,
                        Account.Name,
                        MobilePhone,
                        Email,
                        AccountId
                FROM Contact
                WHERE AccountId = :recordId
        ];

        // 인터페이스 apex data mapping 후 데이터 담음
        IF_KR_SE_HEROKU_0001           instance = IF_KR_SE_HEROKU_0001.getInstance();
        IF_KR_SE_HEROKU_0001.InputDIH  input = new IF_KR_SE_HEROKU_0001.InputDIH();
        IF_KR_SE_HEROKU_0001.T_DATA    tData;
        IF_KR_SE_HEROKU_0001.OutputDIH result;

        // select data 맵핑
        for(Contact con : inputContacts){
            tData = new IF_KR_SE_HEROKU_0001.T_DATA();

            tData.Id = con.Id;
            tData.Name = con.Name;
            tData.AccountName = con.Account.Name;
            tData.Email = con.Email;
            tData.AccountId = con.AccountId;

            input.request.payload.t_data.add(tData);
        }

        // 인터페이스 호출
        if(!input.request.payload.t_data.isEmpty()){
            result = instance.execute(input);
        }

        if ('S'.equals(result.response.header.ifResult)) {
            returnMap.put('STATUS', 'Y');
            returnMap.put('MESSAGE', '' + result.response.payload.t_data);
        }else{
            //실패 Failed to Request
            returnMap.put('STATUS', 'N');
            returnMap.put('MESSAGE', 'Failed to Request : ' + result.response.header.ifFailMsg);
        }

        return returnMap;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, String> callInterFace(String accountId) {
        Map<String, String> returnMap = new Map<String, String>();
        returnMap = IF_KR_SE_HEROKU_0001(accountId);
        return returnMap;
    }
}