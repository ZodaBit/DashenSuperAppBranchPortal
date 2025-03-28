package starter.step_definitions.customers.actions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.junit.Assert;
import starter.assertions.AssertionsAPI;

import static starter.assertions.AssertionsAPI.checkEachItemInResponseContains;
import static starter.utils.BranchApiHelper.*;
import static starter.utils.JsonBodyHelperUtils.*;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE_LOGIN;
import static starter.utils.TestGlobalVariables.getContext;
import static starter.utils.jsons.ChangePhoneNumberJson.*;

public class CustomersActionStepDefinitions {
    @When("I send a POST request to {string} with the user code {string} as a maker")
    public void iSendAPOSTRequestToWithTheUsercode(String endPoint, String userCode) {
        String userCodeJsonBody = String.format(USER_CODE_JSON, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeJsonBody, getParameterProperties(endPoint), token);
    }

    @And("I send a POST request to {string} with the user code {string}, value {} and status {string} as a checker")
    public void iSendAPOSTRequestToWithTheUserCodeAndStatus(String endPoint, String userCode, String status) {
        String userCodeCheckerJsonBody = String.format(USER_CODE_CHECKER_JSON, status, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeCheckerJsonBody, getParameterProperties(endPoint), token);
    }

    @When("I request an access limit for the user code {string} with value {string} as a maker")
    public void iRequestAnAccessLimitForTheUserCodeWithValueAsAMaker(String userCode, String value) {
        boolean accessValue = Boolean.parseBoolean(value);

        String accessControlJsonBody = String.format(CUSTOMER_ACCESS_CONTROL, userCode, accessValue, accessValue, accessValue, accessValue, accessValue, accessValue,
                accessValue, accessValue, accessValue, accessValue, accessValue, accessValue, accessValue,
                accessValue, accessValue, accessValue, accessValue, accessValue, accessValue, accessValue,
                accessValue, accessValue, accessValue, accessValue, accessValue, accessValue, accessValue,
                accessValue, accessValue, accessValue, accessValue, accessValue, accessValue, accessValue);

        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(accessControlJsonBody, getParameterProperties("ep_customer_maker_actions_access_limit"), token);
    }

    @And("I approve the access limit request for the user code {string} with status {string} as a checker")
    public void iApproveTheAccessLimitRequestForTheUserCodeWithStatusAsAChecker(String userCode, String status) {

        String accessControlJsonBody = String.format(USER_CODE_CHECKER_JSON, status, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(accessControlJsonBody, getParameterProperties("ep_customer_checker_actions_access_limit"), token);
    }

    @And("Each item of repsonse by {string} should contain {string}")
    public void eachItemOfRepsonseByShouldContain(String jsonPath, String fieldValue) {
        checkEachItemInResponseContains(jsonPath, fieldValue);
    }

    @And("I send a POST request to {string} user code {string} and phone number {string}")
    public void iSendAPOSTRequestToUserCodeAndPhoneNumber(String endPoint, String userCode, String phoneNumber) {
        Response response = getContext(HTTP_RESPONSE.name());
        String otp = response.path("finalResponse.otp");
    }

    @When("I attempt to change the phone number using the user code {string} and phone number {string} as a maker")
    public void iAttemptToChangeThePhoneNumberUsingTheUserCodeAndPhoneNumber(String userCode, String phoneNumber) {
        String changePhoneNumberJsonBody = String.format(CHANGE_PHONE_NUMBER, userCode, phoneNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(changePhoneNumberJsonBody, getParameterProperties("ep_customer_action_change_phone_number_maker"), token);
    }

    @When("I retrieve and verify the OTP for the user code {string}")
    public void iRetrieveAndVerifyTheOTPForTheUserCode(String userCode) {
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        String userCodeJsonBody = String.format(USER_CODE_JSON, userCode);
        response = postRequestLoginAction(userCodeJsonBody, getParameterProperties("ep_customer_action_change_phone_number_maker_get_OTP"), token);
        int attempts = 0;
        do {
            if (response.path("finalResponse.otp.otpcode") == null) {
                sleep();
                response = postRequestLoginAction(userCodeJsonBody, getParameterProperties("ep_customer_action_change_phone_number_maker_get_OTP"), token);
                attempts++;
            } else {
                break;
            }
        } while (attempts < MAX_RETRIES);

        String otp = response.path("finalResponse.otp.otpcode");
        String verifyOtpJsonBody = String.format(CHANGE_PHONE_NUMBER_VERIFY_OTP, userCode, otp);
        postRequest(verifyOtpJsonBody, getParameterProperties("ep_customer_action_change_phone_number_maker_verify_OTP"), token);
    }

    @When("I review the phone number {string} change request for the user code {string} with status {string} as a checker")
    public void iReviewThePhoneNumberChangeRequestForTheUserCodeWithStatusAsAChecker(String phoneNumber, String userCode, String status) {
        String body = String.format(CHANGE_PHONE_NUMBER_CHECKER, status, userCode, phoneNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(body, getParameterProperties("ep_customer_action_change_phone_number_checker"), token);
    }

    @And("I send a POST request to {string} to activate the account using the user code {string} as a maker")
    public void iSendAPOSTRequestToToActivateTheAccountUsingTheUserCodeAsAMaker(String endPoint, String userCode) {
        String userCodeJsonBody = String.format(USER_CODE_JSON, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeJsonBody, getParameterProperties(endPoint), token, "activate");
    }

    @And("I send a POST request to {string} to reactivate the account using the user code {string} as a maker")
    public void iSendAPOSTRequestToToReactivateTheAccountUsingTheUserCodeAsAMaker(String endPoint, String userCode) {
        String userCodeJsonBody = String.format(USER_CODE_JSON, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeJsonBody, getParameterProperties(endPoint), token, "activate");
    }

    @When("I review a POST request to {string} to activate the change request for the user code {string} with the status {string} as the checker")
    public void iReviewAPOSTRequestToToActivateTheChangeRequestForTheUserCodeWithTheStatusAsTheChecker(String endPoint, String userCode, String status) {
        String userCodeCheckerJsonBody = String.format(USER_CODE_CHECKER_JSON, status, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeCheckerJsonBody, getParameterProperties(endPoint), token, "activate");
    }

    @When("I review a POST request to {string} to reactivate the change request for the user code {string} with the status {string} as the checker")
    public void iReviewAPOSTRequestToToReactivateTheChangeRequestForTheUserCodeWithTheStatusAsTheChecker(String endPoint, String userCode, String status) {
        String userCodeCheckerJsonBody = String.format(USER_CODE_CHECKER_JSON, status, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeCheckerJsonBody, getParameterProperties(endPoint), token, "activate");
    }

    @And("each item in the response body should not have the field {string} set to {string}")
    public void eachItemInTheResponseBodyShouldNotHaveTheFieldSetToNull(String jsonPath, String expectedValue) {
        boolean isNullPresent = AssertionsAPI.filterResponse(jsonPath, expectedValue);
        Assert.assertFalse(isNullPresent);
    }
}
