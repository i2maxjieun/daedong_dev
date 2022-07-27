/**
 * Created by i2max-SanghoonYeo on 2022-07-25.
 */
@IsTest
private class Dummy_IF_Batch_ts {
    private class DummyIFBatchTest extends Dummy_IF_Batch {
        public override Database.QueryLocator start(Database.BatchableContext BC) {
            return Database.getQueryLocator([SELECT Id FROM User LIMIT 1]);
        }

        public override void execute(Database.BatchableContext BC, List<SObject> targetScope) {
            return;
        }

        public override void finish(Database.BatchableContext BC) {
            super.finish(BC);
            return;
        }
    }

    @IsTest
    static void testBehavior() {

        Test.startTest();

        User u = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];

        DummyIFBatchTest batch = new DummyIFBatchTest();
        System.assertNotEquals(batch, null);

        batch.execute(null, new List<User>{u});
        batch.finish(null);

        Test.stopTest();

    }
}