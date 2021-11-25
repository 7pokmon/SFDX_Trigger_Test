/*

    Apex 테스트 클래스.

    1.  모든 테스트 클래스에 대해 맨 위에 @isTest를 사용합니다.
    2.  항상 부정 및 긍정 테스트에 대해 assert 문을 넣습니다.
    3.  testSetup 메서드를 사용하여 테스트 클래스 전체에 흐르는 테스트 데이터를 테스트 클래스에 삽입합니다.
    4.  항상 Test.startTest() 및 Test.stopTest()를 사용하십시오.
        이렇게 하면 Salesforce의 거버너 한도가 증가합니다. 우리는 또한 이것을 주지사의 한도를 늘리는 데 사용합니다.
    5.  System.runAs() 메서드를 사용하여 사용자 컨텍스트에서 기능을 테스트합니다.
    6.  그렇지 않으면 테스트 클래스에 넣지 마십시오(seeAllData = true). 예외적인 경우에 사용하십시오.
    7.  테스트 클래스 또는 에이펙스 클래스의 어디에서나 하드 코딩 ID를 사용하지 마십시오.
    8.  각 클래스에 최소 75%의 적용 범위가 있고 주요 기능도 포함되었는지 확인합니다. 가능하면 코드 적용 범위를 최대 95%까지 늘리십시오.
    9.  모든 클래스 메서드는 최소 200개의 레코드에 대해 테스트해야 하며 실제 시나리오를 염두에두어야 합니다
    10. 하나의 Test.startTest() 및 Test.stopTest() 문만 메서드에 포함될 수 있으며
        모든 테스트 클래스에서 Test.startTest() 및 Test.stopTest() 문은 테스트 메서드에 종속되지 않습니다.
    11. 데이터베이스에 저장하지 않을 테스트 클래스에서 생성한 모든 데이터.(거래가 완료되면 모든 데이터 삭제)

*/
@isTest
public class TestClass1 {
    public TestMethod static void setOpportunityOwner_Method() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Hello';
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        insert opp;

        Task tk = new Task();
        tk.WhatId = opp.Id;
        tk.Subject = 'Other';
        tk.Status = 'Not Started';
        tk.Description = 'New Work';

        Test.startTest();
        Database.SaveResult str = Database.insert(tk, False);
        System.assertEquals(True, str.isSuccess());
        Test.stopTest();
    }
}
