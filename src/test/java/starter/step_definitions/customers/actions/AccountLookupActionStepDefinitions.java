package starter.step_definitions.customers.actions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

import static starter.utils.BranchApiHelper.postRequest;
import static starter.utils.JsonBodyHelperUtils.USER_CODE_JSON;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE_LOGIN;
import static starter.utils.TestGlobalVariables.getContext;
import static starter.utils.jsons.AccountLookUp.*;
import static starter.utils.jsons.ChangePhoneNumberJson.*;

public class AccountLookupActionStepDefinitions {

    @When("I send a POST request to {string} with the account number {string}")
    public void iSendAPOSTRequestToWithTheAccountNumber(String endPoint, String accountNumber) {
        String accountLookupJsonBody = String.format(ACCOUNT_LOOKUP, accountNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(accountLookupJsonBody, getParameterProperties(endPoint), token);

    }

    @And("I send a POST request to {string} with user code {string} and account number {string}")
    public void iSendAPOSTRequestToWithUserCodeAndAccountNumber(String endPoint, String userCode, String accountNumber) {
        String otpAccountLookupJsonBody = String.format(ACCOUNT_LOOKUP_OTP, userCode, accountNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(otpAccountLookupJsonBody, getParameterProperties(endPoint), token);
    }

    @And("I send a POST request to {string} with user code {string}")
    public void iSendAPOSTRequestToWithUserCode(String endPoint, String userCode) {
        String otpDetachPhoneNumberJsonBody = String.format(USER_CODE_JSON, userCode);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(otpDetachPhoneNumberJsonBody, getParameterProperties(endPoint), token);
    }

    @And("I attempt to Detach the phone number using the user code {string} and phone number {string} as a maker")
    public void iAttemptToDetachThePhoneNumberUsingTheUserCodeAndPhoneNumberAsAMaker(String userCode, String phoneNumber) {
        Response otpResponse = getContext(HTTP_RESPONSE.name());
        String otp = otpResponse.path("finalResponse.otp.otpcode");
        String changePhoneNumberJsonBody = String.format(DETACH_PHONE_NUMBER_OTP_MAKER, userCode, phoneNumber, otp);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(changePhoneNumberJsonBody, getParameterProperties("ep_customer_action_account_detach_phone_number_verify_otp"), token);
    }

    @When("I review the detach phone number {string} change request for the user code {string} with status {string} as a checker")
    public void iReviewTheDetachPhoneNumberChangeRequestForTheUserCodeWithStatusAsAChecker(String phoneNumber, String userCode, String status) {
        String body = String.format(DETACH_PHONE_NUMBER_CHECKER, status, userCode, phoneNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(body, getParameterProperties("ep_customer_action_account_detach_phone_number_checker"), token);
    }

    @When("I send a POST request to {string} with user code {string} and phone number {string}")
    public void iSendAPOSTRequestToWithUserCodeAndPhoneNumber(String endPoint, String userCode, String phoneNumber) {
        String body = String.format(ATTACH_PHONE_NUMBER_MAKER, userCode, phoneNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(body, getParameterProperties(endPoint), token);
    }

    @And("I attempt to Attach the phone number using the user code {string} and phone number {string} as a maker")
    public void iAttemptToAttachThePhoneNumberUsingTheUserCodeAndPhoneNumberAsAMaker(String userCode, String phoneNumber) {
        Response otpResponse = getContext(HTTP_RESPONSE.name());
        String otp = otpResponse.path("finalResponse.otp.otpcode");
        String changePhoneNumberJsonBody = String.format(DETACH_PHONE_NUMBER_OTP_MAKER, userCode, phoneNumber, otp);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(changePhoneNumberJsonBody, getParameterProperties("ep_customer_action_account_attach_phone_number_verify_otp_maker"), token);
    }

    @When("I review the attach phone number {string} change request for the user code {string} with status {string} as a checker")
    public void iReviewTheAttachPhoneNumberChangeRequestForTheUserCodeWithStatusAsAChecker(String phoneNumber, String userCode, String status) {
        String body = String.format(DETACH_PHONE_NUMBER_CHECKER, status, userCode, phoneNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(body, getParameterProperties("ep_customer_action_account_attach_phone_number_checker"), token);
    }

    @And("I attempt to unlink account number using the user code {string} and account number {string} as a maker")
    public void iAttemptToUnlinkAccountNumberUsingTheUserCodeAndAccountNumberAsAMaker(String userCode, String accountNumber) {
        Response otpResponse = getContext(HTTP_RESPONSE.name());
        String otp = otpResponse.path("finalResponse.otp.otpcode");
        String unlinkAccountJsonBody = String.format(ACCOUNT_VERIFY_OTP, userCode, accountNumber, otp);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(unlinkAccountJsonBody, getParameterProperties("ep_customer_Action_account_unlink_verify_otp_maker"), token);
    }

    @When("I review the unlink account number {string} change request for the user code {string} with status {string} as a checker")
    public void iReviewTheUnlinkAccountNumberChangeRequestForTheUserCodeWithStatusAsAChecker(String accountNumber, String userCode, String status) {
        String body = String.format(ACCOUNT_UNLINK_CHECKER, status, userCode, accountNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(body, getParameterProperties("ep_customer_Action_account_unlink_checker"), token);
    }

    @And("I attempt to link account number using the user code {string} and account number {string} as a maker")
    public void iAttemptToLinkAccountNumberUsingTheUserCodeAndAccountNumberAsAMaker(String userCode, String accountNumber) {
        Response otpResponse = getContext(HTTP_RESPONSE.name());
        String otp = otpResponse.path("finalResponse.otp.otpcode");
        String unlinkAccountJsonBody = String.format(ACCOUNT_VERIFY_OTP, userCode, accountNumber, otp);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(unlinkAccountJsonBody, getParameterProperties("ep_customer_Action_account_link_verify_otp_maker"), token);
    }

    @When("I review the link account number {string} change request for the user code {string} with status {string} as a checker")
    public void iReviewTheLinkAccountNumberChangeRequestForTheUserCodeWithStatusAsAChecker(String accountNumber, String userCode, String status) {
        String body = String.format(ACCOUNT_UNLINK_CHECKER, status, userCode, accountNumber);
        Response response = getContext(HTTP_RESPONSE_LOGIN.name());
        String token = response.then().extract().jsonPath().getString("token");
        postRequest(body, getParameterProperties("ep_customer_Action_account_link_checker"), token);
    }
}
