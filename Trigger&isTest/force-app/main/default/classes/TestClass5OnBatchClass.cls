global class TestClass5OnBatchClass implements Database.Batchable<Sobject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account a : scope) {
            a.Name += 'Updated';
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {

    }
}
