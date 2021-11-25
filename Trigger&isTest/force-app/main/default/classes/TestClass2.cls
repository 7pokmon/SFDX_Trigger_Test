
/*
    @TestSetUp의 주석은 테스트 클래스에 공통 데이터를 생성하는 테스트 클래스에서 사용된다.
    @TestSetUp메소드에서 생성된 데이터는 테스트 클래스의 모든 테스트 메소드에 공통입니다.
*/
@isTest
public class TestClass2 {
    @TestSetup
    static void setup() {
        List<Account> testAcct = new List<Account>();

        for (Integer i=0; i<2; i++) {
            testAcct.add(new Account(Name = 'TestAcct ' + i));
        }
        insert testAcct;
    }

    @isTest
    static void testMethod1() {
        Account acct = [SELECT Id FROM Account WHERE Name = 'TestAcct 0' LIMIT 1];
        acct.Phone = '555-1212';
        update acct;

        Account acct2 = [SELECT Id FROM Account WHERE Name = 'TestAcct 1' LIMIT 1];
        delete acct2;
    }

    @isTest
    static void testMethod2() {
        Account acct = [SELECT Id FROM Account WHERE Name = 'TestAcct 0' LIMIT 1];
        System.assertEquals(null, acct.Phone);

        Account acct2 = [SELECT Id FROM Account WHERE Name = 'TestAcct 1' LIMIT 1];
        System.assertEquals(null, acct2);
    }
}
