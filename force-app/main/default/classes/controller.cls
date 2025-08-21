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
    public static Map<String, Integer> getDataGraficBar(Integer days, List<String> category){

        if(days == null){
           days = 1000;
        }

        if(category.isEmpty()){
            category.add('Support');
            category.add('Product');
            category.add('Delivery');
        }

        Map<String, Integer> fbData = new Map<String, Integer>();
        Datetime dtBase = System.now() - days;

        fbData.put('Positive', 0);
        fbData.put('Negative', 0);
        fbData.put('Neutral', 0);

        System.debug('Categoria: ' + category);
        
        for(AggregateResult result : [SELECT Sentiment__c, COUNT(Id) total FROM Feedback__c WHERE CreatedDate >= :dtBase AND Category__c = :category GROUP BY Sentiment__c]){
            String rating = String.valueOf(result.get('Sentiment__c'));
            Integer total = Integer.valueOf(result.get('total'));
            fbData.put(rating, total);
        }
        
        return fbData;
    }

    @AuraEnabled
    public static Map<Integer, Integer> getDataFraficDonut(Integer days, List<String> category){

        if(days == null){
           days = 1000;
        }

        if(category.isEmpty()){
            category.add('Support');
            category.add('Product');
            category.add('Delivery');
        }

        Map<Integer, Integer>  fbData = new Map<Integer, Integer>();
        Datetime dtBase = System.now() - days;
        System.debug('Data calculada: ' + dtBase);

        

        for(Integer i = 1; i < 6; i++){
            fbData.put(i, 0);
        }

        for(AggregateResult result : [SELECT Rating__c, COUNT(Id) total from Feedback__c WHERE CreatedDate >= :dtBase AND Category__c = :category GROUP BY Rating__c]){
            Integer total = Integer.valueOf(result.get('total'));
            Integer rating = Integer.valueOf(result.get('Rating__c'));
            fbData.put(rating, total);
        }

        return fbData;
    }
}