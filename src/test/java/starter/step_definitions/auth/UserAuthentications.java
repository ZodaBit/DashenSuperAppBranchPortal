package starter.step_definitions.auth;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import starter.utils.EnvConfig;
import starter.utils.HelperUtils;

import static starter.assertions.AssertionsAPI.*;
import static starter.utils.BranchApiHelper.postRequest;
import static starter.utils.BranchApiHelper.postRequestLogin;
import static starter.utils.JsonBodyHelperUtils.*;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.ACCESS_TOKEN;
import static starter.utils.TestGlobalVariables.ContextEnum.OTP_CODE;
import static starter.utils.TestGlobalVariables.getContext;

public class UserAuthentications {

    @Given("I make a POST request to {string} with the payload")
    public void iMakeAPOSTRequestToWithThePayload(String endpoint) {
        String jsonBody = String.format(USER_PASSCODE_JSON, EnvConfig.getMakerName());
        postRequest(jsonBody, getParameterProperties(endpoint));
    }

    @Then("the response status code should be {int}")
    public void responseShouldHaveStatusCode(int code) {
        checkResponseStatusCode(code);
    }

    @And("the response should contain a field named {string} with the value {string}")
    public void responseShouldContainAFieldNamedWithValue(String jsonPath, String fieldValue) {
        if (fieldValue.equals("null")) {
            checkResponseContains(jsonPath, null);
        } else {
            String field = HelperUtils.resolvePath(fieldValue);
            checkResponseContains(jsonPath, field);
        }
    }

    @When("I make a POST request to {string} with OTP payload and Auth header")
    public void iMakeAPOSTRequestToWithOTPPayloadAndAuthHeader(String arg0) {
        String jsonBody = String.format(USER_PASSCODE_JSON, EnvConfig.getMakerName());
        postRequest(jsonBody, getParameterProperties("ep_user_auth"), EnvConfig.getOtpForHeader());
        checkResponseStatusCode(200);
    }

    @When("I make a POST request to {string} with {string}  and {string}")
    public void iMakeAPOSTRequestToWithAnd(String endpoint, String otpCode, String accessToken) {
        String otp = HelperUtils.resolvePath(otpCode);
        String token = HelperUtils.resolvePath(accessToken);
        String jsonBody = String.format(OTP_CODE_JSON, Integer.parseInt(otp));
        postRequest(jsonBody, getParameterProperties(endpoint), EnvConfig.getOtpForHeader(), token);
    }

    @Given("I send a POST request to {string} with password and {string}")
    public void iSendAPOSTRequestToWithPasswordAnd(String endPoint, String accessToken) {
        String token = HelperUtils.resolvePath(accessToken);
        String jsonBody = String.format(USER_PASSCODE_JSON, EnvConfig.getPassword());
        postRequest(jsonBody, getParameterProperties(endPoint), accessToken);
    }

    @Given("I have a valid access token for the user {string}")
    public void iHaveAValidAccessTokenForTheUser(String userName) {
        String userJsonBody = String.format(USER_PASSCODE_JSON, userName);
        postRequest(userJsonBody, getParameterProperties("ep_new_user_auth"), EnvConfig.getOtpForHeader());
        checkResponseStatusCode(200);
        String otp = getContext(OTP_CODE.name());
        String token = getContext(ACCESS_TOKEN.name());
        String otpJsonBody = String.format(OTP_CODE_JSON, Integer.parseInt(otp));
        postRequest(otpJsonBody, getParameterProperties("ep_user_confirm"), EnvConfig.getOtpForHeader(), token);
    }

    @When("I send a POST request to {string} with the passcode {string}")
    public void whenISendAPOSTRequestToWithThePasscode(String endPoint, String passCode) {
        String otpJsonBody = String.format(USER_PASSWORD_JSON, passCode);
        String token = getContext(ACCESS_TOKEN.name());
        postRequestLogin(otpJsonBody, getParameterProperties(endPoint), EnvConfig.getOtpForHeader(), token);
    }

    @Given("I have a valid access token for {string} endpoint")
    public void iHaveAValidAccessTokenForEndpoint(String endpoint) {
        String jsonBody = String.format(USER_PASSCODE_JSON, EnvConfig.getMakerName());
        postRequest(jsonBody, getParameterProperties(endpoint), EnvConfig.getOtpForHeader());
    }

    @When("I send a POST request to {string} with {string} and passcode {string}")
    public void iSendAPOSTRequestToWithAndPasscode(String endPoint, String accessToken, String passCode) {
        String jsonBody = String.format(USER_PASSWORD_JSON, passCode);
        String token = HelperUtils.resolvePath(accessToken);
        postRequestLogin(jsonBody, getParameterProperties(endPoint), EnvConfig.getOtpForHeader(), token);
    }

    @Given("I send a POST request to {string} with incorrect token")
    public void iSendAPOSTRequestToEndpoint(String endPoint) {
        String otpJsonBody = String.format(USER_PASSWORD_JSON, EnvConfig.getPassword());
        String token = "";
        postRequestLogin(otpJsonBody, getParameterProperties(endPoint), EnvConfig.getOtpForHeader(), token);
    }


    @And("the response {string} should contain one or more items")
    public void theResponseShouldContainOneOrMoreItems(String jsonpath) {
        checkResponseContainOneAndMoreThanOneItem(jsonpath);
    }
}
