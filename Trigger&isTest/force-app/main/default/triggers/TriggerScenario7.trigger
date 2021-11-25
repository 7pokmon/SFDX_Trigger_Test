/*
    시나리오 7.    

    계정 개체에 새 레코드가 생성될 때마다.
    이 새 레코드를 계정에 삽입하기 전에 이 계정 이름을 가진 모든 연락처 레코드를 삭제하십시오
*/
trigger TriggerScenario7 on Account (before insert) {

    List<String> myNames = new List<String>();

    for (Account a : Trigger.new) {
        
        myNames.add(a.Name);
    
    }

    List<Contact> myContacts = [SELECT Id, Name FROM Contact WHERE Name IN :myNames];

    delete myContacts;
}