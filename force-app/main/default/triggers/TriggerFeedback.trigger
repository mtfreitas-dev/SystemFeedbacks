trigger TriggerFeedback on Feedback__c (after insert) {

    FeedbackTriggerHandler handler = new FeedbackTriggerHandler(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);

    switch on Trigger.OperationType {
        when AFTER_INSERT{
            handler.beforeInsert();
        }
    }
}