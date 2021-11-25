/*
    시나리오 3.

    리드가 데이터베이스에 삽입될 때 리드 LastName에 Doctor 접두사를 추가합니다.
    이는 리드 레코드 삽입 및 업데이트 모두에 적용됩니다.
*/
trigger TriggerScenario3 on Lead (before insert, before update) {

    List<Lead> leadList = Trigger.new;

    for (Lead l : leadList) {

        l.LastName = 'Dr' + l.LastName;

    }
}