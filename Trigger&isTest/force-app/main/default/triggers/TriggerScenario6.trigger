/*
    시나리오 6.
    계정 개체에 데이터 유형(텍스트)을 사용하여 "Sales Rep" 이라는 필드를 만들 것입니다.
    계정 레코드를 생성하면 계정 소유자가 Sales Rep 필드에 자동으로 추가됩니다.
    레코드의 계정 소유자를 업데이트하면 영업 담당자도 자동으로 업데이트됩니다.
*/
trigger TriggerScenario6 on Account (before insert, before update) {

    Set<Id> setAccOwner = new Set<Id>();

    for (Account acc : Trigger.new) {

        setAccOwner.add(acc.OwnerId);

    }

    Map<Id,User> UserMap = new Map<Id,User>([SELECT Name FROM User WHERE Id IN :setAccOwner]);

    System.debug('UserMap');

    for (Account acc : Trigger.new) {
        
        User usr = UserMap.get(acc.OwnerId);
        Acc.Sales_Rep__c = usr.Name;
        
    }
}