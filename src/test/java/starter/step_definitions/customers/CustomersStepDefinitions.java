package starter.step_definitions.customers;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import starter.utils.HelperUtils;

import java.util.HashMap;
import java.util.Map;

import static starter.assertions.AssertionsAPI.checkResponseHeader;
import static starter.assertions.AssertionsAPI.checkResponseSize;
import static starter.utils.BranchApiHelper.getRequest;
import static starter.utils.BranchApiHelper.getRequestWithQueryParams;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.getContext;

public class CustomersStepDefinitions {
    @When("I call the GET endpoint {string} without any pagination parameters")
    public void iCallTheGETEndpointWithoutAnyPaginationParameters(String endPoint) {
        Response response = getContext(HTTP_RESPONSE.name());
        String token = response.then().extract().jsonPath().getString("token");
        getRequest(getParameterProperties(endPoint), token);
    }

    @And("the response should have the header {string} set to {string}")
    public void theResponseShouldHaveTheHeaderSetTo(String headerName, String value) {
        checkResponseHeader(headerName, value);
    }

    @And("the response should contain exactly {int} items in the {string} field")
    public void theResponseShouldContainExactlyItemsInTheField(int expectedSize, String jsonPath) {
        checkResponseSize(jsonPath, expectedSize);
    }

    @When("I call GET {string} with pagination parameters")
    public void iCallGETWithPaginationParameters(String endPoint, Map<String, Object> queryParams) {
        Response response = getContext(HTTP_RESPONSE.name());
        String token = response.then().extract().jsonPath().getString("token");
        Map<String, Object> params = new HashMap<>();
        queryParams.forEach((key, value) -> params.put(key, HelperUtils.resolvePath(value.toString())));
        getRequestWithQueryParams(params, getParameterProperties(endPoint), token);
    }

    @When("I send a GET request to {string} with the following query parameter:")
    public void iSendAGETRequestToWithTheFollowingQueryParameter(String endPoint, Map<String, Object> queryParams) {
        Response response = getContext(HTTP_RESPONSE.name());
        String token = response.then().extract().jsonPath().getString("token");
        Map<String, Object> params = new HashMap<>();
        queryParams.forEach((key, value) -> params.put(key, HelperUtils.resolvePath(value.toString())));
        getRequestWithQueryParams(params, getParameterProperties(endPoint), token);
    }


    @When("I make a GET request to {string} to fetch all transactions")
    public void iMakeAGETRequestToToFetchAllTransactions(String endPoint) {
        Response response = getContext(HTTP_RESPONSE.name());
        String token = response.then().extract().jsonPath().getString("token");
        Response getResponse = getRequest(getParameterProperties(endPoint), token);
        String totalDocs = getResponse.then().extract().jsonPath().getString("totalDocs");
        Map<String, Object> params = new HashMap<>();
        params.put("limit", totalDocs);
        getRequestWithQueryParams(params, getParameterProperties(endPoint), token);
    }
}
