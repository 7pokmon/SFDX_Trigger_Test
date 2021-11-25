/*
    시나리오 12.

    Account에서 BillingState를 업데이트하려고 할 때마다
    계정 업데이가되기 전에 관련 Contact에 MailingCity를 업데이트 하도록 하여라
*/
trigger TriggerScenario12 on Account (before update) {

    Map<Id,Account> nMap = new Map<Id,Account>();
    nMap = Trigger.newMap;
    System.debug('nMap ' + nMap);

    List<Contact> cList = [SELECT AccountId, LastName FROM Contact WHERE AccountId IN :nMap.keySet()];

    for (Contact c : cList) {

        Account a = nMap.get(c.AccountId);
        c.MailingCity = a.BillingState;
    }
    update cList;
}