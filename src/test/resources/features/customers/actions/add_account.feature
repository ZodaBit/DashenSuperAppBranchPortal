Feature: Add Account Actions Functionality

  Scenario: 1. Verifying adding an existing account number with a different branch type
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_lookup_maker" with the account number "2928165391711"
    And I send a POST request to "ep_customer_action_account_lookup_otp" with user code "86542002667596" and account number "2928165391711"
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "account branch type mismatch you can't link this account in this branch"
