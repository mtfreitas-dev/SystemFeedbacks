public with sharing class GoogleSentimentService {
    public static String analyzeSentiment(String inputText) {
        String apiKey = 'AIzaSyDyvH58Nkjifwul4G7nEKvSNmst9w5vC5I'; // Cole aqui sua chave gerada
        String endpoint = 'https://language.googleapis.com/v1/documents:analyzeSentiment?key=' + apiKey;

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        // Monta o corpo da requisição
        String body = JSON.serialize(new Map<String, Object>{
            'document' => new Map<String, Object>{
                'type' => 'PLAIN_TEXT',
                'content' => inputText
            },
            'encodingType' => 'UTF8'
        });

        req.setBody(body);

        // Envia requisição
        Http http = new Http();
        HttpResponse res = http.send(req);

        // Trata a resposta
        if (res.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> sentiment = (Map<String, Object>) result.get('documentSentiment');
            Double score = (Double) sentiment.get('score');

            // Interpreta o score
            if (score > 0.25) return 'Positivo';
            if (score < -0.25) return 'Negativo';
            return 'Neutro';
        } else {
            System.debug('Erro: ' + res.getBody());
            return 'Erro';
        }
    }
}