/**
 * Created by MS on 2022-07-27.
 */
@isTest
private class IF_KR_SE_HEROKU_0001_TEST {
    // 입력 객체 생성
    private static IF_KR_SE_HEROKU_0001.InputDIH newInputParameter() {
        IF_KR_SE_HEROKU_0001.InputBody payload = new IF_KR_SE_HEROKU_0001.InputBody();
        IF_KR_SE_HEROKU_0001.InputDIH input = new IF_KR_SE_HEROKU_0001.InputDIH();

        IF_KR_SE_HEROKU_0001.Input inputObj = input.Request;

        inputObj.Header = new IF_Base.InputHeader('a6bba321-2183-5fb4-ff75-4d024e39a98e', 'IF_KR_SE_HEROKU_0001', '20220727000000', 'S', '', '');
        inputObj.Payload = payload;
        return input;
    }

    // HTTPResponse 객체 생성
    private static HTTPResponse newResponse(Integer statusCode) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(statusCode);
        res.setBody('{"Response":{"Header":{"TrackingId":"38a0f138-ca02-a983-ce9d-64dd5caf0911","TaskId":"IF_KR_SE_HEROKU_0001","SenderGroup":"KR","SenderCode":"SE","ResultCode":"S","IFDatetime":"20220727000000","ErrorMsg":"","ErrorCode":"","DestinationGroup":"KR","DestinationCode":"HEROKU"},"Payload":{"TOTAL_RECORD_CNT":"1"}}}');
        IF_KR_SE_HEROKU_0001.OutputDIH temp = (IF_KR_SE_HEROKU_0001.OutputDIH)JSON.deserialize(res.getBody(), IF_KR_SE_HEROKU_0001.OutputDIH.class);
        return res;
    }

    // StatusCode=200 Mock
    private class HttpCalloutSuccessMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = newResponse(200);
            return res;
        }
    }

    // 공통 테스트 진행
    private static Boolean testServiceExecute() {
        String jsonMsg = JSON.serialize(newInputParameter());

        RestRequest  req = new RestRequest ();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/IF_KR_SE_HEROKU_0001';  //Request URL
        req.httpMethod = 'POST';  //HTTP Request Type
        req.requestBody = Blob.valueof(jsonMsg);
        RestContext.request = req;
        RestContext.response = res;

        System.debug('time : ' + String.valueOf(system.now()));

        IF_KR_SE_HEROKU_0001 instance = IF_KR_SE_HEROKU_0001.getInstance();

        // 서비스 실행
        IF_KR_SE_HEROKU_0001.InputDIH input = new IF_KR_SE_HEROKU_0001.InputDIH();
        IF_KR_SE_HEROKU_0001.T_DATA tData = new IF_KR_SE_HEROKU_0001.T_DATA();

        tData.Id            = '0035h00000gbJUOAA2';
        tData.Name          = 'Frank Edna';
        tData.AccountName   = 'GenePoint';
        tData.Email         = 'efrank@genepoint.com';
        tData.AccountId     = '0015h00000u5nC9AAI';

        input.request.payload.t_data.add(tData);

        System.debug('result input : '+ JSON.serialize(input));

        IF_KR_SE_HEROKU_0001.OutputDIH result = instance.execute(input);
        System.debug('result : '+result);

        // crashTest
        IF_Base.crashTest = true;
        result = instance.execute(new IF_KR_SE_HEROKU_0001.InputDIH());

        return true;
    }

    // 성공 테스트
    @isTest public static void testServiceSuccess() {
        Test.setMock(HttpCalloutMock.class, new HttpCalloutSuccessMock());

        System.assertEquals(testServiceExecute(), true);
    }
}