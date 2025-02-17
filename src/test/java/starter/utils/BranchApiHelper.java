package starter.utils;


import io.restassured.http.ContentType;
import io.restassured.response.Response;
import lombok.extern.slf4j.Slf4j;

import static net.serenitybdd.rest.SerenityRest.given;
import static starter.utils.TestGlobalVariables.ContextEnum.*;
import static starter.utils.TestGlobalVariables.setContext;


@Slf4j
public class BranchApiHelper {


    public static String baseApiUrl = EnvConfig.getBaseUrl();

    public static Response postRequest(Object body, String path) {
        Response response = given()
                .contentType(ContentType.JSON)
                .header("sourceapp", EnvConfig.getSourceAppHeader())
                .baseUri(baseApiUrl)
                .basePath(path)
                .body(body)
                .post()
                .then().log().all().extract().response();
        setContext(HTTP_RESPONSE.name(), response);
        return response;
    }

    public static Response postRequest(Object body, String path, String otpFor) {
        Response response = given()
                .contentType(ContentType.JSON)
                .header("sourceapp", EnvConfig.getSourceAppHeader())
                .header("otpfor", otpFor)
                .baseUri(baseApiUrl)
                .basePath(path)
                .body(body)
                .post()
                .then().log().all().extract().response();
        setContext(HTTP_RESPONSE.name(), response);
        setContext(OTP_CODE.name(), response.then().extract().body().jsonPath().get("otp.otpcode"));
        setContext(ACCESS_TOKEN.name(), response.then().extract().body().jsonPath().get("otp.accesstoken"));
        return response;
    }

    public static Response postRequest(Object body, String path, String otpFor, String accessToken) {
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
        setContext(HTTP_RESPONSE.name(), response);
        setContext(ACCESS_TOKEN.name(), response.then().extract().body().jsonPath().get("accesstoken"));
        return response;
    }

    public static Response postRequestLogin(Object body, String path, String otpFor, String accessToken) {
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
        setContext(HTTP_RESPONSE.name(), response);
        return response;
    }

}


