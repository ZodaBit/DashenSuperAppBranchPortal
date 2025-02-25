package starter.step_definitions.customers;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import starter.utils.EnvConfig;

import static starter.utils.BranchApiHelper.postRequestLogin;
import static starter.utils.JsonBodyHelperUtils.*;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.ACCESS_TOKEN;
import static starter.utils.TestGlobalVariables.getContext;

public class CustomersActionStepDefinitions {
    @When("I send a POST request to {string} with the user code {string}")
    public void iSendAPOSTRequestToWithTheUsercode(String endPoint, String userCode) {
        String otpJsonBody = String.format(USER_CODE_JSON, userCode);
        String token = getContext(ACCESS_TOKEN.name());
        postRequestLogin(otpJsonBody, getParameterProperties(endPoint), EnvConfig.getOtpForHeader(), token);
    }

    @And("I send a POST request to {string} with the user code {string} and status {string}")
    public void iSendAPOSTRequestToWithTheUserCodeAndStatus(String endPoint, String userCode, String status) {
        String otpJsonBody = String.format(USER_CODE_CHECKER_JSON, userCode,status);
        String token = getContext(ACCESS_TOKEN.name());
        postRequestLogin(otpJsonBody, getParameterProperties(endPoint), EnvConfig.getOtpForHeader(), token);
    }


    @When("I request an access limit for the user code {string} as a maker")
    public void iRequestAnAccessLimitForTheUserCodeAsAMaker(String userCode) {
        String otpJsonBody = String.format(CUSTOMER_ACCESS_CONTROL, userCode);
        String token = getContext(ACCESS_TOKEN.name());
        postRequestLogin(otpJsonBody, getParameterProperties("ep_customer_maker_actions_access_limit"), EnvConfig.getOtpForHeader(), token);
    }

    @And("I approve the access limit request for the user code {string} with status {string} as a checker")
    public void iApproveTheAccessLimitRequestForTheUserCodeWithStatusAsAChecker(String userCode, String status) {
        String otpJsonBody = String.format(USER_CODE_CHECKER_DENIED_JSON,status,userCode);
        String token = getContext(ACCESS_TOKEN.name());
        postRequestLogin(otpJsonBody, getParameterProperties("ep_customer_checker_actions_access_limit"), EnvConfig.getOtpForHeader(), token);
    }
}
