package starter.utils;

public class JsonBodyHelperUtils {


    public static String OTP_CODE_JSON = """
            {
             "otpcode": %d
            }
            """;

    public static String USER_CODE_JSON = """
                        
             {
                 "userCode": "%s"
             }
                        
            """;

//    public static String USER_CODE_CHECKER_JSON = """
//
//             {
//                 "userCode": "%s",
//                 "decision": "%S"
//             }
//
//            """;

    public static String USER_CODE_CHECKER_JSON = """
                        
             {
                   "decision": "%s",
                   "reason": "automation note",
                   "userCode": "%s"
             }
                        
            """;

    public static String CUSTOMER_ACCESS_CONTROL = """
            {
                "userCode": "%s",
                "access": {
                                   "transfertodashen": %b,
                                   "transfertootherbank": %b,
                                   "ips": %b,
                                   "wallet": %b,
                                   "wallettelebirr": %b,
                                   "walletmpesa": %b,
                                   "topup": %b,
                                   "ethiotelecomtopup": %b,
                                   "safaricomtopup": %b,
                                   "utility": %b,
                                   "schoolfeepay": %b,
                                   "dstv": %b,
                                   "ethiopianairlines": %b,
                                   "trafficpayparking": %b,
                                   "trafficpaypenalty": %b,
                                   "merchantpay": %b,
                                   "microfinance": %b,
                                   "awach": %b,
                                   "sahay": %b,
                                   "requestmoney": %b,
                                   "chat": %b,
                                   "chatsendmoney": %b,
                                   "chatrequestmoney": %b,
                                   "kazna": %b,
                                   "qrpay": %b,
                                   "profilebankingsettings": %b,
                                   "profileaccountsettings": %b,
                                   "addnewaccount": %b,
                                   "linkexistingaccount": %b,
                                   "ministatement": %b,
                                   "miniapps": %b,
                                   "transactionslist": %b,
                                   "balanceview": %b,
                                   "budget": %b
                }
            }
            """;

}
