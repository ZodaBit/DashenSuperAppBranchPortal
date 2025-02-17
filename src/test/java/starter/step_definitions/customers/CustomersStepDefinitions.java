package starter.step_definitions.customers;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import lombok.Value;
import starter.utils.HelperUtils;
import starter.utils.PropertiesReader;

import java.security.Key;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static io.restassured.http.ContentType.JSON;
import static org.hamcrest.Matchers.hasSize;
import static starter.assertions.AssertionsAPI.checkResponseHeader;
import static starter.assertions.AssertionsAPI.checkResponseSize;
import static starter.utils.BranchApiHelper.getRequest;
import static starter.utils.BranchApiHelper.getRequestWithQueryParams;
import static starter.utils.PropertiesReader.getParameterProperties;
import static starter.utils.TestGlobalVariables.ContextEnum.ACCESS_TOKEN;
import static starter.utils.TestGlobalVariables.ContextEnum.HTTP_RESPONSE;
import static starter.utils.TestGlobalVariables.getContext;

public class CustomersStepDefinitions {
    @When("I call the GET endpoint {string} without any pagination parameters")
    public void iCallTheGETEndpointWithoutAnyPaginationParameters(String endPoint) {
        String token = getContext(ACCESS_TOKEN.name());
        getRequest(getParameterProperties(endPoint), token);
    }

    @And("the response should have the header {string} set to {string}")
    public void theResponseShouldHaveTheHeaderSetTo(String headerName, String value) {
        checkResponseHeader(headerName, value);
    }

    @And("the response should contain exactly {int} items in the {string} field")
    public void theResponseShouldContainExactlyItemsInTheField(int expectedSize, String jsonPath) {
        checkResponseSize(jsonPath,expectedSize);;
    }

    @When("I call GET {string} with pagination parameters")
    public void iCallGETWithPaginationParameters(String endPoint,Map<String,Object> queryParams) {
        String token=getContext(ACCESS_TOKEN.name());
        Map<String ,Object> params=new HashMap<>();
        queryParams.forEach((key, value)->params.put(key,HelperUtils.resolvePath(value.toString())));
        getRequestWithQueryParams(params,getParameterProperties(endPoint),token);

    }


}
