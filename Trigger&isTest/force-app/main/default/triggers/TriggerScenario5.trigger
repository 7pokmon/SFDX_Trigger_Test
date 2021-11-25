/*
    시나리오 5.

    계정객체에서 NumberofLocations__c 필드에 입력할 수와 동일한 연락처 수를 생성합니다.
    -account를 생성하면 Related에 Contact가 생성되어야 한다.
*/
trigger TriggerScenario5 on Account (after insert) {

    List<Contact> listContact = new List<Contact>();

    Map<Id,Decimal> mapAcc = new Map<Id,Decimal>();

    for (Account acc : Trigger.new) {

        mapAcc.put(acc.Id, acc.NumberofLocations__c);
        
        System.debug('numberOf : ' + acc.NumberofLocations__c);
        System.debug('Id : ' + acc.Id);
    }

    if (mapAcc.size() > 0 && mapAcc != null) {
        
        for (Id accId : mapAcc.keySet()) {

            for (Integer i=0; i<mapAcc.get(accId); i++) {
                
                System.debug('i : ' + i);
                System.debug('accId : ' + accId);

                Contact newContact = new Contact();

                newContact.accountId = accId;
                newContact.LastName = 'contact' + i;

                listContact.add(newContact);

            }
        }
    }

    insert listContact;

}