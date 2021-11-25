/*
    시나리오 9.

    사용자가 이미 연락처로 존재하는 리드를 생성하지 못하도록 하는 트리거를 작성하십시오.
    리드가 생성되거나 업데이트될 때마다 이메일 주소를 사용하여 중복을 감지합니다.
*/
trigger TriggerScenario9 on Lead (before insert) {

    for (Lead myLead : Trigger.new) {
        
        if (myLead.Email != null) {

            List<Contact> dupes = [SELECT Id FROM Contact WHERE Email = :myLead.Email];

            if (dupes != null && dupes.size() > 0) {

                String errorMessage = 'Duplicate Contact Found !!';
                errorMessage += 'Record ID is ' + dupes[0].Id;
                
                myLead.addError(errorMessage);
            }
        }
    }
}