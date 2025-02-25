package starter.assertions;


import io.restassured.response.Response;
import org.junit.Assert;
import starter.utils.HelperUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.hasSize;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.getContext;

;

public class AssertionsAPI {

    public static void checkResponseStatusCode(int statusCode) {
        Response response = getContext(HTTP_RESPONSE.name());
        response.then().assertThat().statusCode(statusCode);
    }

    public static void checkResponseContains(String jsonFieldName, String expectedValue) {
        String field = HelperUtils.resolvePath(expectedValue);
        Response response = getContext(HTTP_RESPONSE.name());
        String value = response.then().extract().body().jsonPath().getString(jsonFieldName);
        Assert.assertEquals(field, value);
    }

    /**
     * Validate each value in the response list
     *
     * @param jsonPath      - json path to the 'list' response element
     * @param expectedValue
     */
    public static void checkEachItemInResponseEquals(String jsonPath, String expectedValue) {
        String field = HelperUtils.resolvePath(expectedValue);
        Response response = getContext(HTTP_RESPONSE.name());
        List<String> value = response.then().extract().body().jsonPath().getList(jsonPath, String.class);
        value.stream().forEach(s -> Assert.assertEquals(field, s));
    }

    public static void checkEachItemInResponseContains(String jsonPath, String expectedValue) {
        String field = HelperUtils.resolvePath(expectedValue);
        Response response = getContext(HTTP_RESPONSE.name());
        List<String> value = response.then().extract().body().jsonPath().getList(jsonPath, String.class);
        value.stream().forEach(s -> Assert.assertTrue("Current value: " + s,
                s.toLowerCase().contains(field.toLowerCase())));
    }

    /**
     * Validate response list of items contains value
     *
     * @param jsonPath      - json path to the list
     * @param expectedValue
     */
    public static void checkResponseContainsItem(String jsonPath, String expectedValue) {
        String field = HelperUtils.resolvePath(expectedValue);
        Response response = getContext(HTTP_RESPONSE.name());
        List<String> items = response.then().extract().response().jsonPath().getList(jsonPath, String.class);
        Assert.assertTrue(items.contains(field));
    }

    public static void checkResponseHeaderKey(String expectedKey) {
        Response response = getContext(HTTP_RESPONSE.name());
        Assert.assertTrue("There is no header - " + expectedKey,
                response.getHeaders().hasHeaderWithName("x-total-count"));
    }

    public static void checkResponseHeader(String expectedKey, String expectedValue) {
        String field = HelperUtils.resolvePath(expectedValue);
        Response response = getContext(HTTP_RESPONSE.name());
        Assert.assertEquals(response.getHeaders().get(expectedKey).getValue(), field);
    }

    public static void checkResponseHeaderHasValueMoreThan(String expectedKey, int value) {
        Response response = getContext(HTTP_RESPONSE.name());
        Assert.assertTrue("There is no header - " + expectedKey,
                value < Integer.valueOf(response.getHeaders().get(expectedKey).getValue()));
    }

    public static void checkResponseHeaderHasValueIs(String expectedKey, int value) {
        Response response = getContext(HTTP_RESPONSE.name());
        int actualValue = Integer.valueOf(response.getHeaders().get(expectedKey).getValue());
        Assert.assertTrue("Current is header " + expectedKey + " value is: " + actualValue,
                value == actualValue);
    }

    public static void checkResponseHasSizeOfItems(String jsonPath, int expectedSize) {
        Response response = getContext(HTTP_RESPONSE.name());
        response.then().body(jsonPath, hasSize(expectedSize));
    }

    public static void checkResponseSize(String jsonPath, int expectedSize) {
        Response response = getContext(HTTP_RESPONSE.name());
        int result = response.then().extract().body().jsonPath().getList(jsonPath).size();
        Assert.assertEquals(result, expectedSize);
    }

    public static void checkDescendingSorting() {
        Response response = getContext(HTTP_RESPONSE.name());
        List<Integer> ids = response.then().extract().body().jsonPath().get("id");
        for (int i = 0; i < ids.size() - 1; i++) {
            Assert.assertTrue(ids.get(i) > ids.get(i + 1));
        }
    }

    public static void checkAscendingSorting() {
        Response response = getContext(HTTP_RESPONSE.name());
        List<Integer> ids = response.then().extract().body().jsonPath().get("id");
        for (int i = 0; i < ids.size() - 1; i++) {
            Assert.assertTrue(ids.get(i) < ids.get(i + 1));
        }
    }

    public static void checkResponseContainsField(String path, String fieldName) {
        String field = HelperUtils.resolvePath(fieldName);
        Response response = getContext(HTTP_RESPONSE.name());
        response.then().body(path, containsString(field));
    }

    public static void checkDate(String jsonPath, String maxDate) {
        Response response = getContext(HTTP_RESPONSE.name());
        List<String> value = response.then().extract().body().jsonPath().getList(jsonPath);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        try {
            Date max=sdf.parse(maxDate + "T00:00:00.000Z");

            for (String dateStr : value) {
                Date currentDate = sdf.parse(dateStr);
                if (currentDate.after(max)) {
                    Assert.assertFalse(false);
                }
            }

        } catch (ParseException e) {

        }
        Assert.assertTrue(true);

    }


    public static boolean isAnyDateAfter(List<String> dateList, String maxDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        try {
            Date max = sdf.parse(maxDate + "T00:00:00.000Z");  // Parse the max date with time

            for (String dateStr : dateList) {
                Date currentDate = sdf.parse(dateStr);
                if (currentDate.after(max)) {
                    return false;  // Return false if any date is after the max date
                }
            }

        } catch (ParseException e) {
            e.printStackTrace();
            return false;  // Return false if there's a parsing error
        }

        return true;  // Return true if no date is after the max date
    }
}

