/**
 * Created by i2max-SanghoonYeo on 2022-07-25.
 */
@IsTest
private class Dummy_IF_KR_POSTMAN_SF_0001_ba_ts {
    @IsTest
    static void testBehavior() {
        //============================================================================
        // 배치 실행
        //============================================================================\
        Database.executeBatch(new Dummy_IF_KR_POSTMAN_SF_0001_ba(), 200);
    }
}