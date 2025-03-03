Feature: Account Lookup Actions Functionality


  Scenario: 1. Verifying search for an account number that does not exist
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_lookup_maker" with the account number "5085964529042"
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "account doesn't exist"

  Scenario: 2. Verifying search for an existing account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_lookup_maker" with the account number "2928165391711"
    Then the response status code should be 200
    And the response should contain a field named "status" with the value "SUCCESS"
    And the response should contain a field named "data.account_branchtype" with the value "IFB"
    And the response should contain a field named "data.account_branchcode" with the value "C81"
    And the response should contain a field named "data.account_number" with the value "2928165391711"
    And the response should contain a field named "data.customer_number" with the value "C81653917"
    And the response should contain a field named "data.customer_name" with the value "NEBILA SADENER ABAGISSA"
