package starter.step_definitions.transactions;

import io.cucumber.java.en.And;
import org.junit.Assert;

import java.text.SimpleDateFormat;
import java.util.Date;

import static starter.assertions.AssertionsAPI.*;

public class TransactionsStepDefinitions {

    @And("the {string} response should not contain a date later than {string}")
    public void theResponseShouldNotContainADateLaterThan(String jsonPath, String inputDate) {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = inputFormat.parse(inputDate);
            boolean response = checkDateAfter(jsonPath, date);
            Assert.assertTrue(response);
        } catch (Exception e) {
        }
    }

    @And("the {string} response should not contain a date earlier than {string}")
    public void theResponseShouldNotContainADateEarlierThan(String jsonPath, String inputDate) {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = inputFormat.parse(inputDate);
            boolean response = checkBeforeDate(jsonPath, date);
            Assert.assertTrue(response);
        } catch (Exception e) {
        }
    }

    @And("the {string} response should contain a date within the valid range from {string} to {string}")
    public void theResponseShouldContainADateWithinTheValidRangeFromTo(String jsonPath, String dateFrom, String dateTo) {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date startdate = inputFormat.parse(dateFrom);
            Date endDate = inputFormat.parse(dateTo);
            boolean response = checkADateInRange(jsonPath, startdate, endDate);
            Assert.assertTrue(response);
        } catch (Exception e) {
        }
    }

}
