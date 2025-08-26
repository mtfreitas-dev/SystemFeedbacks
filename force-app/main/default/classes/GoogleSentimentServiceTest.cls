@isTest 
public with sharing class GoogleSentimentServiceTest {

    @isTest 
    public static void testNegativeGoogleSentimentQueueable(){

        Test.setMock(HttpCalloutMock.class, new FeedbackNegativeHttpMock());

        // Cria um registro de Feedback fictício
        Feedback__c fb = new Feedback__c(
            Name__c = 'Teste',
            Comment__c = 'Produto péssimo',
            ContactEmail__c = 'teste@gmail.com'
        );
        insert fb;

        Test.startTest();
        // Enfileira o job (Queueable)
        System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        Test.stopTest(); // Executa o job assíncrono

        // Verifica se o sentimento foi atualizado
        Feedback__c updatedFb = [SELECT Id, Sentiment__c FROM Feedback__c WHERE Id = :fb.Id];
        System.assertEquals('Negative', updatedFb.Sentiment__c, 'O sentimento deveria ser Negative');

    } 

    @isTest 
    public static void testePositiveGoogleSentimentQueueable(){
        // Simula resposta da API
        Test.setMock(HttpCalloutMock.class, new FeedbacbkHttpMock());

        // Cria um registro de Feedback fictício
        Feedback__c fb = new Feedback__c(
            Name__c = 'Teste',
            Comment__c = 'Produto muito bom',
            ContactEmail__c = 'teste@gmail.com'
        );
        insert fb;

        Test.startTest();
        // Enfileira o job (Queueable)
        System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        Test.stopTest(); // Executa o job assíncrono

        // Verifica se o sentimento foi atualizado
        Feedback__c updatedFb = [SELECT Id, Sentiment__c FROM Feedback__c WHERE Id = :fb.Id];
        System.assertEquals('Positive', updatedFb.Sentiment__c, 'O sentimento deveria ser Positive');
    }

    @isTest 
    public static void testNeutreGoogleSentimentQueueable(){
        // Simula resposta da API
        Test.setMock(HttpCalloutMock.class, new FeedbacbkNeutreMock());

        // Cria um registro de Feedback fictício
        Feedback__c fb = new Feedback__c(
            Name__c = 'Teste',
            Comment__c = 'Produto muito bom',
            ContactEmail__c = 'teste@gmail.com'
        );
        insert fb;

        Test.startTest();
        // Enfileira o job (Queueable)
        System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        Test.stopTest(); // Executa o job assíncrono

        // Verifica se o sentimento foi atualizado
        Feedback__c updatedFb = [SELECT Id, Sentiment__c FROM Feedback__c WHERE Id = :fb.Id];
        System.assertEquals('Neutral', updatedFb.Sentiment__c, 'O sentimento deveria ser Neutral');
    }

    @isTest
public static void testErrorGoogleSentimentQueueable(){

    // Usa o Mock de erro
    Test.setMock(HttpCalloutMock.class, new FeedbackErrorHttpMock());

    // Cria um registro de Feedback fictício
    Feedback__c fb = new Feedback__c(
        Name__c = 'Teste',
        Comment__c = 'Erro ao analisar sentimento',
        ContactEmail__c = 'teste@gmail.com'
    );
    insert fb;

    Test.startTest();
    // Enfileira o job (Queueable)
    System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
    Test.stopTest(); // Executa o job assíncrono

    // Busca o registro atualizado
    Feedback__c updatedFb = [SELECT Id, Sentiment__c FROM Feedback__c WHERE Id = :fb.Id];

    // Agora validamos o valor "Erro"
    System.assertEquals('Unable to analyze', updatedFb.Sentiment__c, 
        'Em caso de falha da API o sentimento deve ser "Unable to analyze".');
}
}