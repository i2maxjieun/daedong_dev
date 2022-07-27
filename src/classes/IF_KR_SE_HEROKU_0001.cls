/**
 * Created by ms on 2022-07-25.
 */

public with sharing class IF_KR_SE_HEROKU_0001 extends IF_Base {
    private static final String IFID = 'IF_KR_SE_HEROKU_0001'; // External interface id

    private static String IFURL;

    /**
     * JSON 데이터 매핑 변수 입력
     */
    public class T_DATA  {
        public String Id                           ;
        public String Name                         ;
        public String AccountName                  ;
        public String Email                        ;
        public String AccountId                    ;
    }

    /**
     * 수정 불필요 (그대로 사용)
     */
    public class InputBody {
        public List<T_DATA> t_data;
        public InputBody() {
            t_data = new List<T_DATA>();
        }
    }

    /**
     * 수정 불필요 (그대로 사용)
     */
    public class OutputBody {
        public List<T_DATA> t_data;
    }

    /**
     * 수정 불필요 (그대로 사용)
     */
    public class Input extends Headers{
        public InputBody payload;
        public Input(){
            payload = new InputBody();
        }
    }

    /**
     * 수정 불필요 (그대로 사용)
     */
    public class Output extends Headers{
        public OutputBody payload;
        public Output(){
            payload = new OutputBody();
        }
    }
    /**
     * 수정 불필요 (그대로 사용)
     */
    public class InputDIH {
        public Input request;
        public InputDIH(){
            request = new Input();
        }
    }

    /**
     * 수정 불필요 (그대로 사용)
     */
    public class OutputDIH {
        public Output response;
        public OutputDIH(){
            response = new Output();
        }
    }

    /**
     regacy 시스템 url 정보 취득 (IF_Base.getIfinfo())
     */
    private IF_KR_SE_HEROKU_0001() {
        System.debug(IFID+' call');

        IF_INFO__c ifInfo = getIfinfo(IFID);
        IFURL = ifInfo.URL__c;

        System.debug(ifInfo.TITLE__c+' call start');
    }

    /**
     * 개체생성 (수정 불필요)
     */
    private static IF_KR_SE_HEROKU_0001 sInstance = null;
    public static IF_KR_SE_HEROKU_0001 getInstance() {
        if (sInstance == null) {
            sInstance = new IF_KR_SE_HEROKU_0001();
        }
        return sInstance;
    }

    /**
     * realActioin or Batch 에서 execute 호출
     */
    public OutputDIH execute(InputDIH inputObj) {
        OutputDIH outputObj = new OutputDIH();

        String req = null;
        String res = null;

        IF_KR_SE_HEROKU_0001_BIZ bizInstance = null;

        Input  inputReq  = inputObj.Request  ;
        Output outputRes = null              ;
        try {

            inputReq.Header = new IF_Base.InputHeader(IFID);

            bizInstance = IF_KR_SE_HEROKU_0001_BIZ.getInstance();

            /* 업무 개발자에 의해 변경되어야 하는 부분 시작(선행) */
            inputReq.Payload = bizInstance.pre(inputReq.Payload);
            /* 업무 개발자에 의해 변경되어야 하는 부분 끝(선행) */

            // JSON 타입으로 변경
            req = JSON.serialize(inputObj);

            // regacy 시스템 호출
            res = webCallOut(req, IFURL);

            // response 데이터 확인
            outputObj = (OutputDIH)JSON.deserialize(res, OutputDIH.class);
            //outputObj = (OutputDIH)JSON.deserialize('{"response":{"payload":{"ifAggregation":"eb3ca924-cc40-91d4-b69d-587c4004d296","ifSplitSeq":"","ifSplitCnt":"","ifTotCnt":"","t_data":[{"Email":"jrogers@burlington.com","AccountId":"0015i00000ADaMRAA1","Id":"0035i000008j1VkAAI","Name":"Rogers Jack","AccountName":"Burlington Textiles Corp of America"}]},"header":{"ifDateTime":"20220725063738","ifReceiverGp":"LSMTRON","ifResult":"","ifTrackingId":"6d946f9b-3908-b68a-7275-26e6109636cb","ifReceiver":"SE","ifId":"IF_KR_START_END_0001","ifFailCode":"","ifSenderGp":"LSMTRON","ifFailMsg":"","ifSender":"SE"}}}', OutputDIH.class);

            outputRes = outputObj.Response;

            /* 업무 개발자에 의해 변경되어야 하는 부분 시작(후행) */
            outputRes.Payload = bizInstance.post(inputReq.Payload, outputRes.Payload);
            /* 업무 개발자에 의해 변경되어야 하는 부분 끝(후행) */

        } catch(Exception e) {
            // 에러내용 debug 출력
            IF_Comm.errorDebug(e);

            outputRes = outputObj.Response;

            // 내부오류의 경우 ResultCode 'E'로
            outputRes.Header = new IF_Base.InputHeader(inputReq.Header.ifTrackingId, IFID, inputReq.Header.ifDateTime);

            // error header value setup
            outputRes.Header = IF_Base.setOutputHeader(outputRes.Header, inputReq.Header, e);
        }
        res = '';

        return outputObj;
    }
}