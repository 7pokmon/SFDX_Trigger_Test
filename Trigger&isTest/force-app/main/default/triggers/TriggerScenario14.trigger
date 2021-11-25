/*
    시나리오 14.

    사전작업) Account에 필드 Field Update를 체크박스로 생성하라
    Account의 관련 Contact를 insert 하였을 시 Account의 Filed Update가 체크 되게 하여라.
*/
trigger TriggerScenario14 on Contact (after insert) {

    Set<String> accID = new Set<String>();

    for (Contact con : Trigger.new) {

        if (con.AccountId != null) {
            
            accID.add(con.AccountId);
        }
    }

    if (accID.size() > 0) {

        List<Account> accSoql = new List<Account>();        
        accSoql = [SELECT Id, Field_Update__c FROM Account WHERE Id IN :accID AND Field_Update__c != true];

        for (Account a : accSoql) {

            a.Field_Update__c = true;

        }
        update accSoql;
    }

}