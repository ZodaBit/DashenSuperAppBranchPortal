package starter.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestGlobalVariables {


    private static Map<String, Object> context = new HashMap<>();

    public static void setContext(String key, Object value) {
        context.put(key, value);
    }

    @SuppressWarnings("unchecked")
    public static <T> T getContext(String key) {
        return (T) context.getOrDefault(key, null);
    }

    public static List<Object> getContextWithSubKey(String subKey) {
        List<Object> result = new ArrayList<>();
        for (Map.Entry<String, Object> entry : context.entrySet()) {
            if (entry.getKey().contains(subKey)) {
                result.add(entry.getValue());
            }
        }
        return result;
    }

    public static void clearContextWithSubKey(String subKey) {
        context.entrySet().removeIf(entry -> entry.getKey().contains(subKey));
    }


    public enum ContextEnum {
        OTP_CODE,
        ACCESS_TOKEN,
        HTTP_RESPONSE,
    }
}
