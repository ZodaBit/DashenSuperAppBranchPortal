package starter.utils;


import io.restassured.http.ContentType;
import io.restassured.response.Response;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.rest.SerenityRest.given;
import static starter.utils.TestGlobalVariables.ContextEnum.*;
import static starter.utils.TestGlobalVariables.setContext;


@Slf4j
public class BranchApiHelper {


    public static String baseApiUrl = EnvConfig.getBaseUrl();
    public static final int MAX_RETRIES = 5;
    public static final long RETRY_DELAY_MS = 120000;
    public static List<Integer> retryStatusCodes = List.of(500,503);
    public static String message="active OTP: please try again in";


    public static Response postRequestLogin(Object body, String path) {

        int attempts = 0;
        while (attempts < MAX_RETRIES) {
            Response response = given()
                    .contentType(ContentType.JSON)
                    .header("sourceapp", EnvConfig.getSourceAppHeader())
                    .baseUri(baseApiUrl)
                    .basePath(path)
                    .body(body)
                    .post()
                    .then().log().all().extract().response();
            if (retryStatusCodes.contains(response.getStatusCode())) {
                sleep();
                attempts++;
            } else {
                setContext(HTTP_RESPONSE.name(), response);
                return response;
            }
        }
        throw new RuntimeException("Failed to get a successful response after" + MAX_RETRIES + "attempts");
    }

//    public static Response postRequest(Object body, String path, String otpFor) {
//
//        int attempts = 0;
//        while (attempts < MAX_RETRIES) {
//            Response response = given()
//                    .contentType(ContentType.JSON)
//                    .header("sourceapp", EnvConfig.getSourceAppHeader())
//                    .header("otpfor", otpFor)
//                    .baseUri(baseApiUrl)
//                    .basePath(path)
//                    .body(body)
//                    .post()
//                    .then().log().all().extract().response();
//
//            if (retryStatusCodes.contains(response.getStatusCode())) {
//                sleep();
//                attempts++;
//            } else {
//                setContext(HTTP_RESPONSE.name(), response);
//                setContext(ACCESS_TOKEN.name(), response.then().extract().body().jsonPath().get("accesstoken"));
//                return response;
//            }
//        }
//        throw new RuntimeException("Failed to get a successful response after" + MAX_RETRIES + "attempts");
//    }

    public static Response postRequestLogin(Object body, String path,String accessToken) {
        int attempts = 0;
        while (attempts < MAX_RETRIES) {
            Response response = given()
                    .contentType(ContentType.JSON)
                    .header("sourceapp", EnvConfig.getSourceAppHeader())
                    .header("Authorization", "Bearer " + accessToken)
                    .baseUri(baseApiUrl)
                    .basePath(path)
                    .body(body)
                    .post()
                    .then().log().all().extract().response();
            if (retryStatusCodes.contains(response.getStatusCode())) {
                sleep();
                attempts++;
            } else {
                setContext(HTTP_RESPONSE.name(), response);
                setContext(HTTP_RESPONSE_LOGIN.name(),response);
                return response;
            }
        }
        throw new RuntimeException("Failed to get a successful response after" + MAX_RETRIES + "attempts");
    }

    public static Response postRequest(Object body, String path,String accessToken) {
        int attempts = 0;
        while (attempts < MAX_RETRIES) {
            Response response = given()
                    .contentType(ContentType.JSON)
                    .header("sourceapp", EnvConfig.getSourceAppHeader())
                    .header("Authorization", "Bearer " + accessToken)
                    .baseUri(baseApiUrl)
                    .basePath(path)
                    .body(body)
                    .post()
                    .then().log().all().extract().response();
            if (retryStatusCodes.contains(response.getStatusCode())) {
                sleep();
                attempts++;
            } else {
                setContext(HTTP_RESPONSE.name(), response);
                return response;
            }
        }
        throw new RuntimeException("Failed to get a successful response after" + MAX_RETRIES + "attempts");
    }

    public static Response postRequestLogin(Object body, String path, String otpFor, String accessToken) {
        int attempts = 0;
        while (attempts < MAX_RETRIES) {
            Response response = given()
                    .contentType(ContentType.JSON)
                    .header("sourceapp", EnvConfig.getSourceAppHeader())
                    .header("otpfor", otpFor)
                    .header("Authorization", "Bearer " + accessToken)
                    .baseUri(baseApiUrl)
                    .basePath(path)
                    .body(body)
                    .post()
                    .then().log().all().extract().response();
            if (retryStatusCodes.contains(response.getStatusCode()) && response.then().extract().jsonPath().getString("message").contains(message)) {
                sleep();
                attempts++;
            } else {
                setContext(HTTP_RESPONSE.name(), response);
                setContext(ACCESS_TOKEN.name(), response.then().extract().body().jsonPath().get("token"));
                return response;
            }
        }
        throw new RuntimeException("Failed to get a successful response after" + MAX_RETRIES + "attempts");

    }

    public static Response postRequestLoginAction(Object body, String path, String accessToken) {
            Response response = given()
                    .contentType(ContentType.JSON)
                    .header("sourceapp", EnvConfig.getSourceAppHeader())
                    .header("Authorization", "Bearer " + accessToken)
                    .baseUri(baseApiUrl)
                    .basePath(path)
                    .body(body)
                    .post()
                    .then().log().all().extract().response();
                setContext(HTTP_RESPONSE_ACTION.name(), response);
                return response;

    }
    public static Response getRequest(String path, String accessToken) {
        int attempts = 0;
        while (attempts < MAX_RETRIES) {
            Response response = given()
                    .contentType(ContentType.JSON)
                    .header("Authorization", "Bearer " + accessToken)
                    .baseUri(baseApiUrl)
                    .basePath(path)
                    .get()
                    .then().log().all().extract().response();
            if (retryStatusCodes.contains(response.getStatusCode()) && response.then().extract().jsonPath().getString("message").contains(message)) {
                sleep();
                attempts++;
            } else {
                setContext(HTTP_RESPONSE.name(), response);
                return response;
            }
        }
        throw new RuntimeException("Failed to get a successful response after" + MAX_RETRIES + "attempts");
    }

    public static Response getRequestWithQueryParams(Map<String, Object> params, String path, String accessToken) {
        Response response = given()
                .contentType(ContentType.JSON)
                .header("Authorization", "Bearer " + accessToken)
                .baseUri(baseApiUrl)
                .basePath(path)
                .queryParams(params)
                .get()
                .then().log().all().extract().response();
        setContext(HTTP_RESPONSE.name(), response);
        return response;
    }

    public static void sleep() {
        try {
            Thread.sleep(RETRY_DELAY_MS);
        } catch (InterruptedException e) {
            log.error("Error occured while sleeping ", e);
        }
    }

}


