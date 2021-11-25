/*
    200개의 테스트 계정을 생성하여 배치 클래스 테스트한다.
*/
@isTest
private class TestClass5 {
    static testMethod void test() {
        List<Account> accList = new List<Account>();

        for (Integer i=0; i<200; i++) {
            Account m = new Account(Name = 'Account'+i);
            accList.add(m);
        }
        insert accList;
        Test.startTest();
        TestClass5OnBatchClass cb = new TestClass5OnBatchClass();
        Database.executeBatch(cb);
        Test.stopTest();

        Account[] accUpdateList = [SELECT Id, Name FROM Account];
        System.assert(accUpdateList[0].Name.contains('Updated'));
    }
}
