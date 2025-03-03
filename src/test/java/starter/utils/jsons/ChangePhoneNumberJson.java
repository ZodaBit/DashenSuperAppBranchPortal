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

    public static String DETACH_PHONE_NUMBER_OTP_MAKER = """
            {
                "userCode": "%s",
                "phoneNumber": "%s",
                "otpCode": "%s"
            }
            """;

    public static String DETACH_PHONE_NUMBER_CHECKER = """
           {
             "decision": "%s",
             "reason": "automation reason",
             "userCode": "%s",
             "phoneNumber": "%s"
           }
            """;

    public static String ATTACH_PHONE_NUMBER_MAKER = """
           {
             "userCode": "%s",
             "phoneNumber": "%s"
           }
            """;

}
