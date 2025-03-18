package starter.step_definitions.auth;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import starter.utils.EnvConfig;
import starter.utils.HelperUtils;

import static starter.assertions.AssertionsAPI.*;
import static starter.utils.BranchApiHelper.postRequestLogin;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.getContext;
import static starter.utils.jsons.AuthJson.*;

public class UserAuthentications {

    @Given("I make a POST request to {string} with the payload")
    public void iMakeAPOSTRequestToWithThePayload(String endpoint) {
        String jsonBody = String.format(USER_NAME, EnvConfig.getMakerName());
        postRequestLogin(jsonBody, getParameterProperties(endpoint));
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

    @Given("I have a valid access token for the user {string}")
    public void iHaveAValidAccessTokenForTheUser(String userName) {
        String userNameJsonBody = String.format(USER_NAME, userName);
        postRequestLogin(userNameJsonBody, getParameterProperties("ep_user_name_login"));
    }

    @When("I send a POST request to {string} with the passcode {string}")
    public void whenISendAPOSTRequestToWithThePasscode(String endPoint, String passCode) {
        String userPassCodeJsonBody = String.format(USER_PASSWORD, passCode);
        Response response = getContext(HTTP_RESPONSE.name());
        String token = response.then().extract().jsonPath().getString("accesstoken");
        postRequestLogin(userPassCodeJsonBody, getParameterProperties(endPoint), token);
    }

    @Given("I send a POST request to {string} with incorrect token")
    public void iSendAPOSTRequestToEndpoint(String endPoint) {
        String userPassCodeJsonBody = String.format(USER_PASSWORD, EnvConfig.getPassword());
        postRequestLogin(userPassCodeJsonBody, getParameterProperties(endPoint), ACCESS_TOKEN_DUMMY_DATA);
    }

    @And("the response {string} should contain one or more items")
    public void theResponseShouldContainOneOrMoreItems(String jsonpath) {
        checkResponseContainOneAndMoreThanOneItem(jsonpath);
    }


}
