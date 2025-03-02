package starter.utils.jsons;

public class ChangePhoneNumberJson {

    public static String CHANGE_PHONE_NUMBER = """
            {
                "userCode": "%s",
                "newPhoneNumber": "%s",
                "reason": "Automation phone change"
            }
            """;

    public static String CHANGE_PHONE_NUMBER_VERIFY_OTP = """
            {
                "userCode": "%s",
                "otpCode": "%s"
            }
            """;
    public static String CHANGE_PHONE_NUMBER_CHECKER = """
            {
                "decision": "%s",
                "reason": "automation rejected",
                "userCode": "%s",
                "newPhoneNumber": "%s"
            }
            """;
}
