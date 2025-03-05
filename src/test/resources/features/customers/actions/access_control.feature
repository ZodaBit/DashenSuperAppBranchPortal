Feature: Access Control Action Functionality

  Scenario: 1. Verify access control Denial process as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I request an access limit for the user code "72758708821132" with value "true" as a maker
    Then the response status code should be 200

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I approve the access limit request for the user code "72758708821132" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Access limit update declined"

  Scenario: 2. Verify access control false authorization process as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I request an access limit for the user code "72758708821132" with value "false" as a maker
    Then the response status code should be 200

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I approve the access limit request for the user code "72758708821132" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Access limits updated successfully"

  Scenario: 3. Verify access control true authorization process as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I request an access limit for the user code "72758708821132" with value "true" as a maker
    Then the response status code should be 200

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I approve the access limit request for the user code "72758708821132" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Access limits updated successfully"