/*
    시나리오 15. (apex_language_reference 685p)

    새 Shipping invoice 또는 order를 만든 다음 invoice에 항복을 추가합니다.
    총액 Shipping cost를 포함한 order는 invoice에서 추가 또는 삭제된 품목에 기초하여 자동으로 계산되고 업데이트됩니다.

    시나리오 객체 생성 후 필드 작성

    ( Item Object )

    Name                Type            Description
    
    Name                String          이름
    Price               Currency        가격
    Quantity            Number          The number of items in the order : 주문의 항목 수
    Weight              Number          The weight of the item, used to calculate shipping costs : 배송 비용을 계산하는 데 사용되는 항목의 무게
    Shipping_Invoice    Master-detail   The order this item is associated with : 이 항목이 연결된 주문
                        (shipping_invoice)

    ( Shipping invoice Object )

    Name                String          이름
    Subtotal            Currency        Subtotal
    GrandTotal          Currency        The total amount, including tax and shipping : The total amount, including tax and shipping
    Shipping            Currency        The amount charged for shipping (assumes $0.75 per pound) : 배송비 청구 금액(파운드당 $0.75로 가정)
    ShippingDiscount    Currency        Only applied once when subtotal amount reaches $100 : subtotal 금액이 $100에 도달할 때 한 번만 적용됩니다.
    Tax                 Currency        The amount of tax (assumes 9.25%) : 세액(9.25%로 가정)
    Total Weight        Number          The total weight of all items : 모든 품목의 총 중량

*/
trigger TriggerScenario15 on Shipping_Invoice__c (before update) {

    for (Shipping_Invoice__c si : Trigger.new) {

        if (si.Subtotal__c >= 100.00 && si.ShippingDiscount__c == 0) {
            si.ShippingDiscount__c = si.Shipping__c * -1;
            
            si.GrandTotal__c += si.ShippingDiscount__c;
        }
    }
}