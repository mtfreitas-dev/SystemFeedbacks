trigger TriggerFeedback on Feedback__c (before insert) {

    FeedbackTriggerHandler handler = new FeedbackTriggerHandler(Trigger.New, Trigger.old, Trigger.newMap, Trigger.oldMap);

    switch on Trigger.OperationType {
        when BEFORE_INSERT{
            handler.beforeInsert();
        }
    }
}