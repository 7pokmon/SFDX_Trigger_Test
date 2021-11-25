/*
    시나리오 4.

    "Books"라는 개체를 만들고 이 개체 아래에 "Price" 필드(데이터 유형은 통화)를 만듭니다.
    가격 필드에 금액을 입력하고 저장 버튼을 클릭할 때마다 가격 필드에 입력한 값은 실제 가격보다 10% 낮습니다.
    이것은 레코드를 삽입하고 업데이트하는 동안 모두 적용됩니다.
*/
trigger TriggerScenario4 on Book__c (before insert) {

    List<Book__c> books = Trigger.new;

    PriceDiscount.applyDiscount(books);
    
}