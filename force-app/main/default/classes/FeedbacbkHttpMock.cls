@isTest
global class FeedbacbkHttpMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        // Simula retorno da API do Google
        res.setBody('{"documentSentiment":{"score":0.8}}'); // Score positivo
        res.setStatusCode(200);
        return res;
    }
}
