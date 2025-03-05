package starter.step_definitions.customers.actions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

import static starter.utils.BranchApiHelper.postRequest;
import static starter.utils.BranchApiHelper.postRequestLogin;
import static starter.utils.JsonBodyHelperUtils.USER_CODE_CHECKER_JSON;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE_LOGIN;
import static starter.utils.TestGlobalVariables.getContext;
import static starter.utils.jsons.AccountLookUp.ENABLE_USER_MAKER;

public class UserActionsStepDefinitions {

    @When("I review the {string} change request for the user code {string} with status {string}")
    public void iReviewTheChangeRequestForTheUserCodeWithStatus(String endPoint, String userCode, String status) {
        String otpJsonBody = String.format(USER_CODE_CHECKER_JSON, status, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequestLogin(otpJsonBody, getParameterProperties(endPoint), token);
    }

    @And("I attempt to enable the user {string} with the user code {string} as a maker")
    public void iAttemptToEnableTheUserWithTheUserCode(String endPoint, String userCode) {
        Response otpResponse = getContext(HTTP_RESPONSE.name());
        String otp = otpResponse.path("finalResponse.otp.otpcode");
        String enableUserJsonBody = String.format(ENABLE_USER_MAKER, userCode, otp);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(enableUserJsonBody, getParameterProperties(endPoint), token);
    }
}
