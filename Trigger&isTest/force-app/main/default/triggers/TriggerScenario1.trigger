/*
    시나리오 1.

    동일한 이름으로 계정을 만들려고 할 때 발생합니다.
    즉, 사용자가 중복 계정을 만들지 못하도록 방지합니다.
*/
trigger TriggerScenario1 on Account (before insert) {
    
    for (Account a :Trigger.new) {

        // 동일한 이름 존재시 acc에 저장
        List<Account> acc = [SELECT Id FROM Account WHERE Name = :a.Name];

        // 저장된 값이 존재할 시 addError 
        if (acc.size() > 0) {

            a.Name.addError('Duplicate Account Name');
        
        }
    }
}