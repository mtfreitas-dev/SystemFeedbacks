public with sharing class FeedbackHelper {

    //Método estático que chama o serviço externo de sentimento para uma lista de feedbacks
    //Static method that calls the external sentiment service for a list of feedbacks
    public static void ExternalFeedbackService(List<Feedback__c> newRecords){

        for(Feedback__c fb : newRecords){
            //Enfileira a execução do serviço de sentimento usando a interface Queueable
            //Queues the execution of the sentiment service using the Queueable interface
            if(fb.Sentiment__c == null || fb.Sentiment__c == ''){
                System.debug('Passei aqui');
                System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
            }
        }
    }
}