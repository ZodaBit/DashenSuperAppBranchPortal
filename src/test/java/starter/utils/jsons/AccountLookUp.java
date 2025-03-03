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
    public static String ACCOUNT_LOOKUP_VERIFY= """
            {
                "userCode": "%s",
                "accountNumber": "%s",
                "otpCode": "%s"
            }
            """;
}
