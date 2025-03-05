package starter.utils.jsons;

public class AccountLookUp {

    public static String ACCOUNT_LOOKUP = """
            {
                "account_number": "%s"
            }
            """;

    public static String ACCOUNT_LOOKUP_OTP= """
            {
                "userCode": "%s",
                "accountNumber": "%s"
            }
            """;
    public static String ACCOUNT_VERIFY_OTP= """
            {
                "userCode": "%s",
                "accountNumber": "%s",
                "otpCode": "%s"
            }
            """;
    public static String ACCOUNT_UNLINK_CHECKER= """
            {
               "decision": "%s",
               "reason": "automation rejected",
               "userCode": "%s",
               "accountNumber": "%s"
            }
            """;

    public static String ENABLE_USER_MAKER= """
            {
                    "userCode": "%s",
                    "reason": "Automation reject",
                    "otpCode": "%s"
                }
            """;

}

