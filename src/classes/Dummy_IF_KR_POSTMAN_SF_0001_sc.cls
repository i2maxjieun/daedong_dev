/**
 * Created by i2max-SanghoonYeo on 2022-07-25.
 */

public class Dummy_IF_KR_POSTMAN_SF_0001_sc implements Schedulable {
    // Schedule 등록 배치명
    private static String batchName = 'DummyBatch_IF_KR_ERP_SE_0001';
    /** Schedule Cron Expression (5분)
     *  초(0~59) | 분(0~59) | 시(0~23) | 일(1~31) | 월(1~12) | 요일(1~7)-일요일부터시작 | 년(optional)
     */
    private static String batchCron = '0 5 * * * ? *';
    // Batch 수행 Size
    private static Integer batchSize = 200;

    /**
     * 배치 실행 멤버 함수(override)
     *
     * @param SC : SchedulableContext
     */
    public void execute(SchedulableContext SC) {
        Dummy_IF_KR_POSTMAN_SF_0001_sc.excuteBatch();
    }

    /**
     * 배치 Schedule 등록
     * developer console > Debug > Open Execute Anonymous > Dummy_IF_KR_POSTMAN_SF_0001_sc.runSchedule(); 기입 후 execute 실행
     */
    public static void runSchedule() {
        System.schedule(batchName, batchCron, new Dummy_IF_KR_POSTMAN_SF_0001_sc());
    }

    /**
     *  배치 Schedule 삭제
     * developer console > Debug > Open Execute Anonymous > Dummy_IF_KR_POSTMAN_SF_0001_sc.abortSchedule(); 기입 후 execute 실행
     */
    public static void abortSchedule() {
        for (CronTrigger t : [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = :batchName]) {
            if(!Test.isRunningTest())   System.abortJob(t.Id);
        }
    }

    /**
     * 배치 실행
     * Dummy_IF_KR_POSTMAN_SF_0001_sc.excuteBatch();
     */
    public static void excuteBatch() {
        Database.executeBatch(new Dummy_IF_KR_POSTMAN_SF_0001_ba(), batchSize);
    }
}