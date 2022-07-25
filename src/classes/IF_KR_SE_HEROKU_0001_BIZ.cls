/**
 * Created by ms on 2022-07-25.
 */

public with sharing class IF_KR_SE_HEROKU_0001_BIZ {
    private static IF_KR_SE_HEROKU_0001_BIZ sInstance = null;
    public static IF_KR_SE_HEROKU_0001_BIZ getInstance() {
        if (sInstance == null) {
            sInstance = new IF_KR_SE_HEROKU_0001_BIZ();
        }
        return sInstance;
    }

    /**
     * pre logic
     */
    public IF_KR_SE_HEROKU_0001.InputBody pre(IF_KR_SE_HEROKU_0001.InputBody inputBody) {
        /* 업무 개발자에 의해 변경되어야 하는 부분 시작 */


        /* 업무 개발자에 의해 변경되어야 하는 부분 끝 */

        return inputBody;
    }

    /**
     * post logic
     */
    public IF_KR_SE_HEROKU_0001.OutputBody post(IF_KR_SE_HEROKU_0001.InputBody inputBody, IF_KR_SE_HEROKU_0001.OutputBody outputBody) {
        /* 업무 개발자에 의해 변경되어야 하는 부분 시작 */


        /* 업무 개발자에 의해 변경되어야 하는 부분 끝 */
        return outputBody;
    }
}