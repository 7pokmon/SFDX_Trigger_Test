/*
    시나리오 2.
    
    계정을 생성하거나 계정 레코드를 업데이트할 때마다 Website필드에 네이버 URL값으로 필드를 업데이트합니다.
*/
trigger TriggerScenario2 on Account (before insert, before update) {

    List<Account> accs = Trigger.new;

    HelloWorld my = new HelloWorld();

    my.addHelloWorld(accs);

}