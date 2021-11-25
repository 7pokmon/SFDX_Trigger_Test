@isTest
private class TestClass4 {
    static testMethod void testMe() {
        Lead l = new Lead();
        l.FirstName = 'Salesforce';
        l.Company = 'Codes';
        l.LastName = 'Codes';
        l.LeadSource = 'Web';
        l.Status = 'Open - Not Contacted';
        
        insert l;

        Test.startTest();
        TestClass4OnBatchClass ba = new TestClass4OnBatchClass();
        Id jobId = Database.executeBatch(ba, 5);
        Test.stopTest();

        Lead leads = [SELECT Rating FROM Lead WHERE Id = :l.Id];
        System.debug('leads.Rating : ' + leads.Rating);
        System.assertEquals('Warm', leads.Rating);
    }
}