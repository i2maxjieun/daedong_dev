/**
 * Created by i2max-SanghoonYeo on 2022-07-25.
 */

public class Dummy_IF_KR_POSTMAN_SF_0001_ba extends Dummy_IF_Batch {

    public String query;

    // 배치를 동작시키기 전, Records or Objects 데이터들을 가져오기 위해 작성.
    public override Database.QueryLocator start(Database.BatchableContext BC) {

        this.interfaceId = 'IF_KR_POSTMAN_SF_0001';

        query = 'SELECT CustomerName__c, CustomerType__c, Phone__c, isBatchCompleted__c FROM IF_KR_POSTMAN_SF_0001__c WHERE isBatchCompleted__c = FALSE';

        return Database.getQueryLocator(query);
    }

    // 가져온 Records or Objects 를 통해 배치 수행내용 구현
    public override void execute(Database.BatchableContext BC, List<SObject> targetScope) {

        // insert 할 List
        List<SObject> targetInsList = new List<SObject>();
        // update 할 List
        List<SObject> targetUpdList = new List<SObject>();
        // update 할 Dummy List
        List<SObject> targetDmlDummyList = new List<SObject>();

        Account tmpAccount, tmpExistAccount;
        String customerName;

        //중복검사위해 Name 담을 Map
        Map<String,SObject> DummyName = new Map<String,SObject>();
        //Account를 담을 Map
        Map<String, Account> AccountByName = new Map<String, Account>();

        //중복여부
        Boolean isExistRecord;

        //중복검사를 위해 Dummy의 Name을 Key로 담아준다.(운영 시 유니크한 키 사용)
        for(SObject dummy : targetScope){
            DummyName.put((String)dummy.get('CustomerName__c'),dummy);
        }

        //중복검사를 위해 Dummy와 동일한 Name의 Account Select
        for(Account account : [
                SELECT Name
                FROM Account
                WHERE Name IN :DummyName.keySet()
        ]){
            AccountByName.put(account.Name,account);
        }

        for(SObject dummy : targetScope) {
            //처리여부 true
            dummy.put('isBatchCompleted__c',true);

            customerName = (String) dummy.get('CustomerName__c');

            tmpExistAccount = AccountByName.get(customerName);
            isExistRecord = tmpExistAccount != null ? true : false;

            if(isExistRecord){ //기존 있는 Data
                tmpExistAccount.CustomerType__c = (String) dummy.get('CustomerType__c');
                tmpExistAccount.Phone = (String) dummy.get('Phone__c');
                targetUpdList.add(tmpAccount = tmpExistAccount);
            }else{ //새로운 신규 Data
                targetInsList.add(tmpAccount = new Account(
                        Name = customerName,
                        CustomerType__c = (String) dummy.get('CustomerType__c'),
                        Phone = (String) dummy.get('Phone__c')
                ));
            }
            targetDmlDummyList.add(dummy);
        }

        System.Savepoint sp;
        try {
            sp = Database.setSavepoint();
            insert targetInsList;
            update targetUpdList;
        }
        catch(Exception e) {
            Database.rollback(sp);
            System.debug(System.LoggingLevel.ERROR, '::::: ERROR LOG ' + e);
        }
        finally {
            update targetDmlDummyList;
        }
    }

    public override void finish(Database.BatchableContext BC) {
        super.finish(BC);
    }
}