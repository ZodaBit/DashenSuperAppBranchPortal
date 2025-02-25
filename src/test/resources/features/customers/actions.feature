Feature: Customer Action Functionality

  Scenario: 1. reset pin
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_actions_reset_pin" with the user code "72758708821132"
    And I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_login" with the passcode "Admin@7"
    And I send a POST request to "ep_customer_checker_actions_reset_pin" with the user code "72758708821132" and status "AUTHORIZED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP sent successfully."

  Scenario: 2. Verify access limit denied process
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I request an access limit for the user code "72758708821132" as a maker
    And I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_login" with the passcode "Admin@7"
    And I approve the access limit request for the user code "72758708821132" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Access limit update declined"

  Scenario: 3. Verify access limit approval process
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I request an access limit for the user code "72758708821132" as a maker
    And I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_login" with the passcode "Admin@7"
    And I send a POST request to "ep_customer_checker_actions_access_limit" with the user code "72758708821132" and status "AUTHORIZED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Access limits updated successfully"


#DENIED
#  Scenario: 1. Verify access limit approval process
#    Given I have a valid access token for the user "zolam"
#    And I am logged in with the passcode "Abc@123"
#    When I send a POST request to "ep_customer_maker_actions_access_limit" with the user code "72758708821132" as a maker
#    And I have a valid access token for the user "bini2"
#    And I am logged in with the passcode "Admin@7"
#    And I send a POST request to "ep_customer_checker_actions_access_limit" with the user code "72758708821132" and status "AUTHORIZED" as a checker
#    Then the response status code should be 200
#    And the response should contain a field named "message" with the value "OTP sent successfully."
#
#  Scenario: 1. Verify access limit approval process
#    Given I have a valid access token for the user "zolam"
#    And I am logged in with the passcode "Abc@123"
#    When I request an access limit for the user code "72758708821132" as a maker
#    And I have a valid access token for the user "bini2"
#    And I am logged in with the passcode "Admin@7"
#    And I approve the access limit request for the user code "72758708821132" with status "AUTHORIZED" as a checker
#    Then the response status code should be 200
#    And the response should contain a field named "message" with the value "OTP sent successfully."
#
