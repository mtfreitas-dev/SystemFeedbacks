@isTest
global class FeedbackErrorHttpMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(500); // Erro interno do servidor
        res.setBody('{"error":"Internal Server Error"}');
        return res;
    }
}
