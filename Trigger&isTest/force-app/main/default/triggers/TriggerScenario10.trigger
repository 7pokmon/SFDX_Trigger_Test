/*
    시나리오 10.

    Trigger.old를 이용하여 Contact의 LastName과 Phone을 수정하였을시
    수정하기전의 Contact 내용을 account에 insert 하여라
*/
trigger TriggerScenario10 on Contact (before update) {

    List<Account> accList = new List<Account>();

    for (Contact c : Trigger.old) {

        Account a = new Account();
        a.Name = c.LastName;
        a.Phone = c.Phone;

        accList.add(a);
    }

    insert accList;
}