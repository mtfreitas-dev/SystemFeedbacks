public with sharing class FeedbackTriggerHandler {

    List<Feedback__c> oldRecords {get;set;}
    List<Feedback__c> newRecords {get;set;}
    Map<Id, Feedback__c> oldMap {get;set;}
    Map<Id, Feedback__c> newMap {get;set;}

    public FeedbackTriggerHandler(List<Feedback__c> oldRecords, List<Feedback__c> newRecords, Map<Id, Feedback__c> oldMap, Map<Id, Feedback__c> newMap){
        this.oldRecords = oldRecords;
        this.newRecords = newRecords;
        this.oldMap = oldMap;
        this.newMap = newMap;
    }

    public static void beforeInsert(){

    }
}