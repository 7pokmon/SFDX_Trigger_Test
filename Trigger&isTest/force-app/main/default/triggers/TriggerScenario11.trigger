/*
    시나리오 11.

    Account의 Phone을 수정하였을 시 수정한 Account에 Name과 동일한 Contact에 
    Account Name이 적혀있는 Phone이 수정되도록 한다. 

    Trigger.isAfter = 
    모든 레코드를 저장한 후 이 트리거가 발생한 경우 TRUE를 반환합니다.
    Trigger.isUpdate = 
    업데이트 작업으로 인해 Salesforce 사용자 인터페이스, apex 또는 API에서 이 트리거가 발생한 경우 TRUE를 반환합니다.
*/
trigger TriggerScenario11 on Account (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {

        Set<Id> ids = new Set<Id>();
        List<Contact> conList = new List<Contact>();

        for (Account a : Trigger.new) {
            
            ids.add(a.Id);
            
            List<Contact> cont = [SELECT Id, Phone, LastName, Account.Phone FROM Contact WHERE AccountId IN :ids];
            
            for (Contact c : cont) {
                c.Phone = c.Account.Phone;
                conList.add(c);
            }

            update conList;
        }
    }
}