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

    public static String USER_CODE_CHECKER_JSON = """
                        
             {
                 "userCode": "%s",
                 "decision": "%S"
             }
                        
            """;

    public static String USER_CODE_CHECKER_DENIED_JSON = """
                        
             {
                   "decision": "%S",
                   "reason": "automation note",
                   "userCode": "%s"
             }
                        
            """;
    public static String CUSTOMER_ACCESS_CONTROL = """
            {
                "userCode": "%S",
                "access": {
                                   "transfertodashen": true,
                                    "transfertootherbank": true,
                                    "ips": true,
                                    "wallet": true,
                                    "wallettelebirr": false,
                                    "walletmpesa": true,
                                    "topup": true,
                                    "ethiotelecomtopup": true,
                                    "safaricomtopup": true,
                                    "utility": true,
                                    "schoolfeepay": true,
                                    "dstv": true,
                                    "ethiopianairlines": true,
                                    "trafficpayparking": true,
                                    "trafficpaypenalty": true,
                                    "merchantpay": true,
                                    "microfinance": true,
                                    "awach": true,
                                    "sahay": true,
                                    "requestmoney": true,
                                    "chat": true,
                                    "chatsendmoney": true,
                                    "chatrequestmoney": true,
                                    "kazna": true,
                                    "qrpay": true,
                                    "profilebankingsettings": true,
                                    "profileaccountsettings": true,
                                    "addnewaccount": true,
                                    "linkexistingaccount": true,
                                    "ministatement": true,
                                    "miniapps": true,
                                    "transactionslist": true,
                                    "balanceview": true,
                                    "budget": true
                }
            }
            """;




}
