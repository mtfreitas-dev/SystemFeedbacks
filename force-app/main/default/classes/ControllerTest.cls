@isTest()
public with sharing class ControllerTest {

    @isTest 
    public static void testgetFeedbacks(){
        Test.setMock(HttpCalloutMock.class, new FeedbacbkHttpMock());

        List<Feedback__c> feedbackList = new List<Feedback__c>();
        for(Integer i = 0; i < 4; i++){
            feedbackList.add(new Feedback__c(Name__c = 'name ' + i, Comment__c = 'Gostei muito ' + i, ContactEmail__c = 'email' + 1 + '@gmail.com', Rating__c = '5' ));
        }
        insert feedbackList;
        
        Test.startTest();
        for (Feedback__c fb : feedbackList) {
            System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        }
        Test.stopTest();

        List<Feedback__c> result = controller.getFeedbacks();

        System.assertEquals(4, result.size());

    }

    @IsTest 
    public static void testGetSentimentData(){

        Test.setMock(HttpCalloutMock.class, new FeedbacbkHttpMock());

        List<Feedback__c> fbList = new List<Feedback__c>();
        fbList.add(new Feedback__c(Name__c = 'Teste 01', Comment__c = 'Gostei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5'));
        fbList.add(new Feedback__c(Name__c = 'Teste 02', Comment__c = 'Gostei médio ', ContactEmail__c = 'email@gmail.com', Rating__c = '3'));
        fbList.add(new Feedback__c(Name__c = 'Teste 03', Comment__c = 'Odiei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '1'));

        insert fbList;

        Test.startTest();
        for (Feedback__c fb : fbList) {
            System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        }
        Test.stopTest();

        Map<String, Integer> result = controller.getSentimentData();
        System.debug('Result ' + result);
   
        System.Assert.areEqual(3, result.get('Positive'));
    }   

    @isTest 
    public static void testgetFeedbacksData(){
        
        Test.setMock(HttpCalloutMock.class, new FeedbacbkHttpMock());

        List<Feedback__c> fbList = new List<Feedback__c>();
        fbList.add(new Feedback__c(Name__c = 'Teste 01', Comment__c = 'Gostei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5'));
        fbList.add(new Feedback__c(Name__c = 'Teste 02', Comment__c = 'Gostei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5'));
        fbList.add(new Feedback__c(Name__c = 'Teste 03', Comment__c = 'Gostei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5'));

        insert fbList;

        Map<Integer, Integer> result = controller.getFeedbacksData();
        System.Assert.areEqual(3, result.get(5));
    }

    @isTest 
    public static void testGetDataGraficBar(){
        Test.setMock(HttpCalloutMock.class, new FeedbacbkHttpMock());

        List<Feedback__c> fbList = new List<Feedback__c>();
        fbList.add(new Feedback__c(Name__c = 'Teste 01', Comment__c = 'Gostei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5', Category__c = 'Support'));
        fbList.add(new Feedback__c(Name__c = 'Teste 02', Comment__c = 'Gostei médio ', ContactEmail__c = 'email@gmail.com', Rating__c = '3', Category__c = 'Support'));
        fbList.add(new Feedback__c(Name__c = 'Teste 03', Comment__c = 'Odiei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '1',  Category__c = 'Support'));

        insert fbList;



        Test.startTest();
        for (Feedback__c fb : fbList) {
            System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        }
        Test.stopTest();

        for(Feedback__c fb : fbList) {
            System.debug('Sentimento FB ' + fb.Sentiment__c);
        }

        Map<String, Integer> result = controller.getDataGraficBar(7, new List<String>());
        System.debug('Result ' + result);

        Map<String, Integer> resultNull = controller.getDataGraficBar(null, new List<String>());
        System.debug('Result ' + result);
        
   
        System.Assert.areEqual(3, result.get('Positive'));
        System.Assert.areEqual(3, result.get('Positive'));

    }

    @isTest
    public static void testGetDataFraficDonut(){
        Test.setMock(HttpCalloutMock.class, new FeedbacbkHttpMock());

        List<Feedback__c> fbList = new List<Feedback__c>();
        fbList.add(new Feedback__c(Name__c = 'Teste 01', Comment__c = 'Gostei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5', Category__c = 'Support'));
        fbList.add(new Feedback__c(Name__c = 'Teste 02', Comment__c = 'Gostei médio ', ContactEmail__c = 'email@gmail.com', Rating__c = '5', Category__c = 'Support'));
        fbList.add(new Feedback__c(Name__c = 'Teste 03', Comment__c = 'Odiei muito ', ContactEmail__c = 'email@gmail.com', Rating__c = '5',  Category__c = 'Support'));

        insert fbList;



        Test.startTest();
        for (Feedback__c fb : fbList) {
            System.enqueueJob(new GoogleSentimentService(fb.Id, fb.Comment__c));
        }
        Test.stopTest();

        for(Feedback__c fb : fbList) {
            System.debug('Sentimento FB ' + fb.Sentiment__c);
        }

        Map<Integer, Integer> result = controller.getDataFraficDonut(7, new List<String>());
        System.debug('Result ' + result);

        Map<Integer, Integer> resultNull = controller.getDataFraficDonut(null, new List<String>());
        System.debug('Result ' + result);
        
   
        System.Assert.areEqual(3, result.get(5));
        System.Assert.areEqual(3, result.get(5));
    }
}
