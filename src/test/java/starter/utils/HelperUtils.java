package starter.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.Assert;

import java.util.UUID;
import java.util.regex.Matcher;

import static starter.utils.Constants.PATTERN_NAMED_PARAM_TO_UPPER_CASE;
import static starter.utils.TestGlobalVariables.getContext;


@Slf4j
public class HelperUtils {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static String resolvePath(final String apiPath) {
        if (apiPath == null) {
            return null;
        }
        StringBuilder resolvedPath = new StringBuilder();
        Matcher matcher = Constants.PATTERN_NAMED_PARAM_HINT_PROPERTY.matcher(apiPath);
        while (matcher.find()) {
            String propertyName = matcher.group(1);
            // Check for special properties...
            if (propertyName.startsWith(Constants.NAMED_PARAM_HINT_NUMBER_OF_LENGTH)) {
                int length = Integer.parseInt(propertyName.substring(propertyName.lastIndexOf(":") + 1));
                matcher.appendReplacement(resolvedPath, RandomStringUtils.randomNumeric(length));
            } else if (propertyName.startsWith(Constants.NAMED_PARAM_HINT_STRING_OF_LENGTH)) {
                int length = Integer.parseInt(propertyName.substring(propertyName.lastIndexOf(":") + 1));
                matcher.appendReplacement(resolvedPath, RandomStringUtils.randomAlphanumeric(length));
            } else if (propertyName.startsWith(Constants.NAMED_PARAM_HINT_GENERATED_UUID)) {
                matcher.appendReplacement(resolvedPath, UUID.randomUUID().toString());
            } else if (propertyName.startsWith(Constants.TO_UPPER_CASE)) {
                matcher.appendReplacement(resolvedPath, resolvePathToUpperCase(propertyName));
            } else {
                Assert.assertNotNull(propertyName + " not persisted.", getContext(propertyName));
                matcher.appendReplacement(resolvedPath, getContext(propertyName).toString());
            }
        }
        matcher.appendTail(resolvedPath);
        return resolvedPath.toString();
    }

    public static String resolvePathToUpperCase(final String apiPath) {
        Matcher matcher = PATTERN_NAMED_PARAM_TO_UPPER_CASE.matcher(apiPath);
        if (matcher.find()) {
            String matchedString = matcher.group(1);
            return matchedString.toUpperCase();
        }
        return apiPath;
    }

    public static <T> T convertJsonToObject(String json, Class<T> clazz) {
        try {
            return objectMapper.readValue(json, clazz);
        } catch (Exception e) {
            log.error("Failed to convert json to object", e);
            return null;
        }
    }

    public static <T> String convertObjectToJson(T object) {
        try {
            return objectMapper.writeValueAsString(object);
        } catch (Exception e) {
            log.error("Failed to convert object to json", e);
            return null;
        }
    }
}
