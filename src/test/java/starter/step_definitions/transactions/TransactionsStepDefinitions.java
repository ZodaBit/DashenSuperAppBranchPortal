package starter.step_definitions.transactions;

import io.cucumber.java.en.And;
import starter.assertions.AssertionsAPI;

public class TransactionsStepDefinitions {

    @And("the {string} response should not contain a date later than {string}")
    public void theResponseShouldNotContainADateLaterThan(String jsonPath, String Date) {
        AssertionsAPI.checkDate(jsonPath,Date);
    }
}
