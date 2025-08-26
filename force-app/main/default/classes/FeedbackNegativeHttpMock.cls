@isTest
global class FeedbackNegativeHttpMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        // Simula retorno da API do Google
        res.setBody('{"documentSentiment":{"score":-1}}'); // Score negativo
        res.setStatusCode(200);
        return res;
    }
}