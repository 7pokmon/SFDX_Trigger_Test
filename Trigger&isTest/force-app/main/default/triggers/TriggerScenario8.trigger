/*
    시나리오 8.

    새 연락처가 생성될 때마다 새 연락처 전화 필드로 해당 계정 전화를 업데이트합니다.
*/
trigger TriggerScenario8 on Contact (after insert) {

    List<Account> acc = new List<Account>();

    for (Contact c : Trigger.new) {

        Account a = [SELECT Id, Phone FROM Account WHERE Id = :c.AccountId];
        
        a.Phone = c.Phone;
        acc.add(a);
    }
    
    update acc;
}