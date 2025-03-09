Feature: Activate and Reactivate Account Actions Functionality

  Scenario: 1. Verifying Activate account  DENIED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    And I send a POST request to "ep_customer_action_reset_activate_maker" to activate the account using the user code "123977159518" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Activate account request initiated."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review a POST request to "ep_customer_action_reset_activate_checker" to activate the change request for the user code "123977159518" with the status "DENIED" as the checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP sending declined"

  Scenario: 2. Verifying Activate account  AUTHORIZED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    And I send a POST request to "ep_customer_action_reset_activate_maker" to activate the account using the user code "123977159518" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Activate account request initiated."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review a POST request to "ep_customer_action_reset_activate_checker" to activate the change request for the user code "123977159518" with the status "AUTHORIZED" as the checker
    Then the response status code should be 200
    And the response should contain a field named "finalResponse.message" with the value "OTP sent successfully"

  Scenario: 3. Verifying Reactivate account  DENIED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_reactivate_maker" to reactivate the account using the user code "123977159518" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Device reactivate request initiated, pending checker approval."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review a POST request to "ep_customer_action_reactivate_checker" to reactivate the change request for the user code "123977159518" with the status "DENIED" as the checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP sending declined"

  Scenario: 4. Verifying Reactivate account  AUTHORIZED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_reactivate_maker" to reactivate the account using the user code "123977159518" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Device reactivate request initiated, pending checker approval."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review a POST request to "ep_customer_action_reactivate_checker" to reactivate the change request for the user code "123977159518" with the status "AUTHORIZED" as the checker
    Then the response status code should be 200
    And the response should contain a field named "finalResponse.message" with the value "OTP sent successfully"
