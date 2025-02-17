package starter.utils;

public class JsonBodyHelperUtils {

    public static String USER_PASSCODE_JSON = """
            {
            "username": "%s"
            }
            """;


    public static String OTP_CODE_JSON = """
            {
             "otpcode": %d
            }
            """;

    public static String USER_PASSWORD_JSON = """
                        
             {
                 "password": "%s"
             }
                        
            """;
}
