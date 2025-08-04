public with sharing class FeedbackTriggerHandler {

    //Armazena os valores que serão manipulados
    //Stores the values ​​that will be manipulated

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

    //Este método aciona outras funções quando a trigger na condição before insert é acionada
    //This method triggers other functions when the trigger in the before insert condition is fired

    public void beforeInsert(){
        FeedbackHelper.ExternalFeedbackService(newRecords);
    }
}