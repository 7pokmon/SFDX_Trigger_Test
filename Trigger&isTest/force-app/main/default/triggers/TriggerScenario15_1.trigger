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
trigger TriggerScenario15_1 on item__c (after insert, after update, after delete) {

    Map<Id,Shipping_Invoice__c> updateMap = new Map<Id,Shipping_Invoice__c>();
    
    Integer subtrack;
    List<Item__c> itemList;

    if (Trigger.isInsert || Trigger.isUpdate) {

        subtrack = 1;
        itemList = Trigger.New;

    } else if(Trigger.isDelete) {
        
        subtrack = -1;
        itemList = Trigger.old;
    
    }

    Set<Id> AllItems = new Set<Id>();

    for (item__c i : itemList) {
        
        System.assert(i.Quantity__c >0, 'Quantity must be positive');
        System.assert(i.Weight__c >=0, 'Weight must be non-negative');
        System.assert(i.Price__c >=0, 'Price must be non-negative');
        
        AllItems.add(i.Shipping_Invoice__c);
    }

    List<Shipping_Invoice__c> AllShippingInvoices = [SELECT Id, ShippingDiscount__c,
                                                     Subtotal__c, TotalWeight__c, Tax__c, GrandTotal__c
                                                     FROM Shipping_Invoice__c WHERE Id IN :AllItems];
    
    Map<Id,Shipping_Invoice__c> SIMap = new Map<Id,Shipping_Invoice__c>();

    for (Shipping_Invoice__c sc : AllShippingInvoices) {

        SIMap.put(sc.Id, sc);
    }

    // Process the list of items
    if (Trigger.isUpdate) {

        for(Integer x=0; x<Trigger.old.size(); x++) {

            Shipping_Invoice__c myOrder;
            myOrder = SIMap.get(Trigger.old[x].Shipping_Invoice__c);
            
            // 기존의 값들을 제거하고
            myOrder.Subtotal__c -= (Trigger.old[x].Price__c * Trigger.old[x].Quantity__c);
            myOrder.TotalWeight__c -= (Trigger.old[x].weight__c * Trigger.old[x].quantity__c);

            // 새로운 값을 추가한다.
            myOrder.Subtotal__c += (Trigger.new[x].Price__c * Trigger.new[x].Quantity__c);
            myOrder.TotalWeight__c -= (Trigger.new[x].weight__c * Trigger.new[x].quantity__c);
        }

        // Tax, Shipping, GrandTotal값 계산 후
        for(Shipping_Invoice__c myOrder : AllShippingInvoices) {

            myOrder.Tax__c = myOrder.Subtotal__c * .0925;
            myOrder.ShippingDiscount__c = 0;
            myOrder.Shipping__c = (myOrder.TotalWeight__c * .75);
            myOrder.GrandTotal__c = myOrder.Subtotal__c + myOrder.Tax__c + myOrder.Shipping__c;

            updateMap.put(myOrder.Id, myOrder);
        }

    } else  {
        // insert, delete 상황
        
        // item 객체 수정
        for (Item__c itemToProcess : itemList) {

            Shipping_Invoice__c myOrder;

            myOrder = SIMap.get(itemToProcess.Shipping_Invoice__c);

            myOrder.Subtotal__c += (itemToProcess.Price__c * itemToProcess.Quantity__c * subtrack);
            myOrder.TotalWeight__c += (itemToProcess.Weight__c * itemToProcess.Quantity__c * subtrack);
        }

        // Shipping_Invoice 객체 수정
        for (Shipping_Invoice__c myOrder : AllShippingInvoices) {
            
            myOrder.Tax__c = myOrder.Subtotal__c * .0925;
            myOrder.ShippingDiscount__c = 0;

            myOrder.Shipping__c = (myOrder.TotalWeight__c * .75);
            myOrder.GrandTotal__c = myOrder.Subtotal__c + myOrder.Tax__c + myOrder.Shipping__c;

            updateMap.put(myOrder.Id, myOrder);
        }
    }

    update updateMap.values();
}