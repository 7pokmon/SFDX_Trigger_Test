global class TestClass4OnBatchClass implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT LeadSource, Rating FROM Lead');
    }

    global void excute(Database.BatchableContext bc, List<Lead> scope) {
        for (Lead l : scope) {
            if (l.LeadSource == 'Web') {
                l.Rating = 'Warm';
            }
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc) {
        
    }
}
