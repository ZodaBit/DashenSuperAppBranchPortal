package starter.step_definitions.customers.actions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

import static starter.utils.BranchApiHelper.postRequest;
import static starter.utils.JsonBodyHelperUtils.USER_CODE_CHECKER_JSON;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE_LOGIN;
import static starter.utils.TestGlobalVariables.getContext;
import static starter.utils.jsons.AccountLookUp.ENABLE_USER_MAKER;
import static starter.utils.jsons.TransferLimitJson.TRANSFER_LIMIT_PAYLOAD;

public class TransferLimitActionStepDefinitions {

    @And("I send a POST request to {string} to verify the OTP for the user code {string}")
    public void iSendAPOSTRequestToToVerifyTheOTPForTheUserCode(String endPoint, String userCode) {
        Response otpResponse = getContext(HTTP_RESPONSE.name());
        String otp = otpResponse.path("finalResponse.otp.otpcode");
        String enableUserJsonBody = String.format(ENABLE_USER_MAKER, userCode, otp);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(enableUserJsonBody, getParameterProperties(endPoint), token);
    }

    @When("I set the transaction limits for user {string}, service {string}, one-time limit {string}, and daily limit {string} as a maker")
    public void iSetTheTransactionLimitsForUserServiceOneTimeLimitAndDailyLimit(String userCode, String serviceName, String oneTimeLimit, String dailyLimit) {
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        String transferLimitJsonBody = String.format(TRANSFER_LIMIT_PAYLOAD, userCode, serviceName, Integer.parseInt(oneTimeLimit), Integer.parseInt(dailyLimit));
        postRequest(transferLimitJsonBody, getParameterProperties("ep_customer_action_transfer_update_limit_maker"), token);

    }

    @When("I review the {string} status transfer limit change request for user code {string} as a checker")
    public void iReviewTheStatusTransferLimitChangeRequestForUserCodeAsAChecker(String status, String userCode) {
        String userCodeCheckerJsonBody = String.format(USER_CODE_CHECKER_JSON, status, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(userCodeCheckerJsonBody, getParameterProperties("ep_customer_action_transfer_limit_checker"), token);
    }
}



