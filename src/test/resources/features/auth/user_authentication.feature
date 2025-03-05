Feature:  User Authentication

  Scenario: 1. Verify that the user has set a password after authentication
    Given I make a POST request to "ep_user_check" with the payload
    Then the response status code should be 200
    And the response should contain a field named "passwordset" with the value "true"

  Scenario: 2. Verify authentication succeeds with the correct OTP and token
    Given I have a valid access token for the user "zolam"
    When I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    Then the response status code should be 200
    And the response should contain a field named "user.userName" with the value "zolam"
    And the response should contain a field named "user.roleId" with the value "MAKER"
    And the response should contain a field named "user.branchName" with the value "KALITY BRANCH"

  Scenario: 3. Verify Authentication Fails with Incorrect OTP Token
    Given I send a POST request to "ep_user_passcode_login" with incorrect token
    Then the response status code should be 403
    And the response should contain a field named "type" with the value "AUTHENTICATION_ERROR"

  Scenario: 4. Verify Authentication Fails with Incorrect passcode
    Given I have a valid access token for the user "zolam"
    When I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123e"
    Then the response status code should be 400
    And the response should contain a field named "status" with the value "false"



