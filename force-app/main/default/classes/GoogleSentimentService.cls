public with sharing class GoogleSentimentService implements Queueable, Database.AllowsCallouts {

    //Variáveis para armazenar o ID do feedback e a mensagem a ser analisada
    //Variables to store the feedback ID and the message to be analyzed
    private Id feedbackId;
    private String message;

    //Construtor que recebe o ID do feedback e a mensagem como parâmetros
    //Constructor that receives feedback ID and message as parameters
    public GoogleSentimentService(Id feedbackId, String message) {
        this.feedbackId = feedbackId;
        this.message = message;
    }

    //Método executado quando a fila é processada
    //Method executed when the queue job runs
    public void execute(QueueableContext context) {
        //Chamada do método para analisar o sentimento da mensagem
        //Calling the method to analyze the sentiment of the message
        String returnGoogleAnalytics = analyzeSentiment(message);

        //Criação de um novo objeto Feedback__c com o sentimento retornado
        //Creating a new Feedback__c record with the returned sentiment
        Feedback__c fb = new Feedback__c(
            Id = feedbackId,
            Sentiment__c = returnGoogleAnalytics
        );

        //Log para depuração
        //Debug log
        System.debug('fb:' + fb);

        //Atualização do registro de feedback
        //Updating the feedback record
        update fb;
    }

    //Método privado que realiza a chamada à API do Google para análise de sentimento
    //Private method that performs a call to Google's sentiment analysis API
    private String analyzeSentiment(String inputText) {
        //Chave de API do Google (substituir por variável segura em produção)
        //Google API key (replace with secure variable in production)
        String apiKey = 'AIzaSyDyvH58Nkjifwul4G7nEKvSNmst9w5vC5I';

        //Endpoint da API do Google Natural Language
        //Google Natural Language API endpoint
        String endpoint = 'https://language.googleapis.com/v1/documents:analyzeSentiment?key=' + apiKey;

        //Criação da requisição HTTP
        //Creating the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        //Montagem do corpo da requisição com o texto a ser analisado
        //Building the request body with the text to be analyzed
        String body = JSON.serialize(new Map<String, Object>{
            'document' => new Map<String, Object>{
                'type' => 'PLAIN_TEXT',
                'content' => inputText
            },
            'encodingType' => 'UTF8'
        });

        req.setBody(body);

        //Envio da requisição HTTP
        //Sending the HTTP request
        Http http = new Http();
        HttpResponse res = http.send(req);

        //Tratamento da resposta da API
        //Handling the API response
        if (res.getStatusCode() == 200) {

            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> sentiment = (Map<String, Object>) result.get('documentSentiment');
            Double score = (Double) sentiment.get('score');

            //Retorno do sentimento com base no score
            //Returning sentiment based on score
            if (score > 0.25) return 'Positive';
            if (score < -0.25) return 'Negative';
            return 'Neutral';
        } else {
            //Log de erro e retorno de mensagem padrão em caso de falha
            //Error log and returning default message in case of failure
            System.debug('Erro na resposta da API: ' + res.getBody());
            return 'Erro';
        }
    }
}