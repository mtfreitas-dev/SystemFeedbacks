public with sharing class controller {

    @AuraEnabled
    public static List<Feedback__c> getFeedbacks(){
        return [SELECT Id, Name__c, ContactEmail__c, Comment__c, Sentiment__c, Rating__c FROM Feedback__c WHERE Sentiment__c != null AND Name__c != null LIMIT 4];
    }

    @AuraEnabled
    public static Map<Integer, Integer> getFeedbacksData(){

        Map<Integer, Integer> feedbackData = new Map<Integer, Integer>();

        for(AggregateResult result : [SELECT Rating__c, COUNT(Id) total FROM Feedback__c  WHERE Rating__c != null GROUP BY Rating__c]){

            Integer rating = Integer.valueOf(result.get('Rating__c'));
            Integer total = Integer.valueOf(result.get('total'));

            feedbackData.put(rating, total);
        }

        return feedbackData;
    }

    @AuraEnabled
    public static Map<String, Integer> getSentimentData(){
        List<AggregateResult> result = [SELECT Sentiment__c, Count(Id) total FROM Feedback__c GROUP BY Sentiment__c];
        Map<String, Integer> sentimentMap = new Map<String, Integer>();
        
        for(AggregateResult rs : result){
            Integer total = (Integer)rs.get('total');
            String sentiment = (String)rs.get('Sentiment__c');
            sentimentMap.put(sentiment, total);
        }
        return sentimentMap;
    }

    @AuraEnabled
    public static string teste(){
        return 'teste';
    }
}