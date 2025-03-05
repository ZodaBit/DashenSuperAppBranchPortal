Feature: Customer Reset Pin Action Functionality

  Scenario: 1. Verify denied reset pin approval action process
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_reset_activate_maker" with user code "72758708821132"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Reset PIN request initiated. OTP will be sent shortly."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "ep_customer_action_reset_activate_checker" change request for the user code "72758708821132" with status "DENIED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP sending declined"

  Scenario: 2. Verify authorization reset pin approval action process
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_reset_activate_maker" with user code "72758708821132"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Reset PIN request initiated. OTP will be sent shortly."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "ep_customer_action_reset_activate_checker" change request for the user code "72758708821132" with status "AUTHORIZED"
    Then the response status code should be 200
    And the response should contain a field named "finalResponse.message" with the value "OTP sent successfully"
