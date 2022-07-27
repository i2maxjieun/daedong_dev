/**
 * Created by i2max-SanghoonYeo on 2022-07-25.
 */

public abstract class Dummy_IF_Batch implements Database.Batchable<SObject>, Database.Stateful {
    /**
     * 실행 일자
     */
    protected Datetime exeDatetime = System.now();
    protected Date exeDate = exeDatetime.date();

    /**
     * bad or dml error Dummy Data Ids
     */
    protected List<Id> errorDummyIds = new List<Id>();

    /**
     * 실행 인터페이스 Id
     */
    protected String interfaceId;

    /**
     * Start
     *
     * @param BC : BatchableContext
     *
     * @return Database.QueryLocator
     */
    public abstract Database.QueryLocator start(Database.BatchableContext BC);

    /**
     * execute
     *
     * @param BC : BatchableContext
     * @param targetScope : Batch Size 실행 리스트
     */
    public abstract void execute(Database.BatchableContext BC, List<SObject> targetScope);

    /**
     * finish
     * 로직의 순서 중요[유의]
     *
     * @param BC : BatchableContext
     */
    public virtual void finish(Database.BatchableContext BC) {
        //============================================================================
        // 정상처리가 안된 Dummy Record 의 Ids 로깅처리
        //============================================================================
        if(this.errorDummyIds.isEmpty() == false) {
            System.debug(System.LoggingLevel.ERROR, '::::: errorDummyids : ' + String.join(this.errorDummyIds, ', '));
        }

    }
}