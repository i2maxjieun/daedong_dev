/****************************************************************************************
  * File Name   : IF_Base
  * Description : IF_Base
  * Author      : ldb3100
  * Modification Log
  * ===============================================================
  * Ver  Date        Author     Modification
  * ===============================================================
    1.0  2020.03.09  ldb3100    Create
****************************************************************************************/
public virtual with sharing class IF_Base {

    public static boolean crashTest = false;

    public class IFException extends Exception {}



    /**
     * JSON InputHeader of all request header
     */
    public class InputHeader{
        public String ifId              {get;set;}  // External interface id, created automatically, so need logic
        public String ifSenderGp        {get;set;}  // Source System Group
        public String ifSender          {get;set;}  // Source System Code
        public String ifReceiverGp      {get;set;}  // Target System Group
        public String ifReceiver        {get;set;}  // Target System Code
        public String ifTrackingId      {get;set;}  // This should Unique ID from client system to be used for tracking of transaction from client perspective. GUID for message
        public String ifDateTime        {get;set;}  // interface datetime
        public String ifResult          {get;set;}  // interface result status
        public String ifFailMsg         {get;set;}  // interface result error message
        public String ifFailCode        {get;set;}  // interface result error code

        public InputHeader(){
            // 빈생성자
        }
        public InputHeader(String TaskId){
            this.ifId           = TaskId        ;
            this.ifResult       = ''            ;
            this.ifFailMsg      = ''            ;
            this.ifFailCode     = ''            ;
            genMsg();
        }
        public InputHeader(String TaskId, String IFDateTime){
            this.ifId           = TaskId        ;
            this.ifResult       = ''            ;
            this.ifFailMsg      = ''            ;
            this.ifFailCode     = ''            ;
            this.ifTrackingId   = giveGUID()    ;
            this.ifDateTime     = IFDateTime    ;
        }
        public InputHeader(String TrackingId, String TaskId, String IFDateTime){
            this.ifTrackingId   = TrackingId    ;
            this.ifId           = TaskId        ;
            this.ifDateTime     = IFDateTime    ;
        }
        public InputHeader(String TrackingId, String TaskId, String IFDateTime, String ResultCode, String ErrorMsg, String ErrorCode){
            this.ifTrackingId   = TrackingId    ;
            this.ifId           = TaskId        ;
            this.ifDateTime     = IFDateTime    ;
            this.ifResult       = ResultCode    ;
            this.ifFailMsg      = ErrorMsg      ;
            this.ifFailCode     = ErrorCode     ;
        }
        public void genMsg(){
            this.ifTrackingId   = giveGUID();
            this.ifDateTime     = datetime.now().formatGmt('YYYYMMddHHmmss');
        }
        public String giveGUID(){
            Blob   b    = Crypto.GenerateAESKey(128);
            String h    = EncodingUtil.ConvertTohex(b);
            String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.subString(20);
            return guid;
        }
    }

    public static String giveAGGR(){
        Blob   b    = Crypto.GenerateAESKey(128);
        String h    = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.subString(20);
        return guid;
    }

    public virtual class Header{
        public InputHeader Header {get;set;}
        public Header(){
            Header = new InputHeader();
        }
    }
    
    public virtual class Headers{
        public InputHeader header {get;set;}
        public Headers(){
            Header = new InputHeader();
        }
    }

    // Oauth Class
    public class Oauth{
        public string id;
    }

    public static InputHeader setOutputHeader(InputHeader output, InputHeader input) {
        output.ifTrackingId     = input.ifTrackingId    ;

        output.ifSenderGp       = input.ifReceiverGp    ;
        output.ifSender         = input.ifReceiver      ;
        output.ifReceiverGp     = input.ifSenderGp      ;
        output.ifReceiver       = input.ifSender        ;

        return output;
    }

    public static InputHeader setOutputHeader(InputHeader output, InputHeader input, Exception e) {
        output.ifSenderGp       = input.ifReceiverGp    ;
        output.ifSender         = input.ifReceiver      ;
        output.ifReceiverGp     = input.ifSenderGp      ;
        output.ifReceiver       = input.ifSender        ;

        output.ifResult         = 'E'                   ;
        output.ifFailCode       = e.getTypeName()       ;
        output.ifFailMsg        = IF_Comm.errorText(e)  ;

        return output;
    }

    public static String webCallOut(String body, String endpoint){
        system.debug('=================================> Start Request : ' + endpoint);

        HttpRequest httpReq = new HttpRequest();
        //RestResponse httpRes = new RestResponse;
        HttpResponse httpRes = new HttpResponse();
        Http http = new Http();
        String resBody = null;

        httpReq.setMethod('POST');
        httpReq.setBody(body);
        httpReq.setEndpoint(endpoint);
        httpReq.setTimeout(110000);
        //httpReq.setHeader('Authorization', authEnc());
        httpReq.setHeader('Authorization', 'Bearer ' + '00D5i000005mSkr!AQoAQBznaAvTSFpkveUx_79guNkQ.bnx1vPjB2FR.Nww.1lDdB5iu4UYsIKg1rBSfuoB6aSy_rNN7.hCynAlR8wNwnu0eOKP');
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json');
        httpRes = http.send(httpReq);

        System.debug('response Header Key : ' + httpRes.getHeaderKeys());

        System.debug('response Status Code : ' + httpRes.getStatusCode());
        System.debug('response Status : ' + httpRes.getStatus());

        resBody = httpRes.getBody();
        if (resBody.length() > 1900000) {
            System.debug('responseBody : null');
        } else {
            System.debug('responseBody : '+resBody);
        }
        return resBody;
    }

}