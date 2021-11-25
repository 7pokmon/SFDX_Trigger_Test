/*
    시나리오 13.

    Account에서 Phone을 업데이트하려고 할 때마다 계정 업데이트되기 전에 
    관련 Contact에 Phone을 새 계정 번호로 업데이트하십시오.
    계정 레코드를 삭제하면 해당 연락처 레코드를 삭제합니다.
*/
trigger TriggerScenario13 on Account (before update, after delete) {

    if (Trigger.isBefore && Trigger.isUpdate) {

        Map<Id,Account> myMap = new Map<Id,Account>();
        myMap = Trigger.newMap;

        List<Contact> cons = new List<Contact>();
        cons = [SELECT Id, Phone, AccountId FROM Contact WHERE AccountId IN :myMap.keySet()];

        for (Contact c: cons) {
            
            c.Phone = myMap.get(c.AccountId).Phone;
        }
        update cons;
    }

    if (Trigger.isAfter && Trigger.isDelete) {

        Map<Id,Account> deleteAcc = new Map<Id,Account>();
        deleteAcc = Trigger.oldMap;

        List<Contact> myContact = [SELECT Id FROM Contact WHERE AccountId IN :deleteAcc.keySet()];

        delete myContact;
    }
} 