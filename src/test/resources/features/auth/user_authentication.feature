Feature:  User Authentication

  Scenario: 1. Verify that the user has set a password after authentication
    Given I make a POST request to "ep_user_check" with the payload
    Then the response status code should be 200
    And the response should contain a field named "passwordset" with the value "true"

  Scenario: 2. Verify authentication succeeds with the correct OTP and token
    Given I have a valid access token for the user "zolam"
    When I send a POST request to "ep_user_login" with the passcode "Abc@123"
    Then the response status code should be 200
    And the response should contain a field named "user.userName" with the value "zolam"
    And the response should contain a field named "user.roleId" with the value "MAKER"
    And the response should contain a field named "user.branchName" with the value "KALITY BRANCH"

  Scenario: 3. Verify Authentication Fails with Incorrect OTP Token
    Given I send a POST request to "ep_user_login" with incorrect token
    Then the response status code should be 401
    And the response should contain a field named "error" with the value "Unauthorized: Invalid Bearer token format"

  Scenario: 4. Verify Authentication Fails with Incorrect passcode
    Given I have a valid access token for the user "zolam"
    When I send a POST request to "ep_user_login" with the passcode "Abc@123e"
    Then the response status code should be 400
    And the response should contain a field named "status" with the value "false"

  Scenario: 5. Verify authentication failure to login with "ep_user_auth" endpoint Token
    Given I have a valid access token for "ep_new_user_auth" endpoint
    When I send a POST request to "ep_user_login" with "!ACCESS_TOKEN!" and passcode "Abc@123"
    Then the response status code should be 400
    And the response should contain a field named "status" with the value "false"

