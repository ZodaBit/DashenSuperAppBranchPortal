Feature: Enable And Disable Account Actions Functionality


  Scenario: 1. Verifying user disable  DENIED  action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    And I send a POST request to "ep_disable_user_maker" with user code "129676245406479"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Awaiting approval for disable user."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "ep_disable_user_checker" change request for the user code "129676245406479" with status "DENIED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Disable user declined"

  Scenario: 2. Verifying user disable  AUTHORIZED  action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    And I send a POST request to "ep_disable_user_maker" with user code "129676245406479"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Awaiting approval for disable user."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "ep_disable_user_checker" change request for the user code "129676245406479" with status "AUTHORIZED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Message sent successfully via SMS"

  Scenario: 3. Verifying user enable  DENIED  action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_enable_user_maker_otp" with user code "129676245406479"
    And I attempt to enable the user "ep_enable_user_maker_verify_otp" with the user code "129676245406479" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Awaiting approval for enable user."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "ep_enable_user_checker" change request for the user code "129676245406479" with status "DENIED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "User enable request declined"

  Scenario: 4. Verifying user enable  AUTHORIZED  action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_enable_user_maker_otp" with user code "129676245406479"
    And I attempt to enable the user "ep_enable_user_maker_verify_otp" with the user code "129676245406479" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Awaiting approval for enable user."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "ep_enable_user_checker" change request for the user code "129676245406479" with status "AUTHORIZED"
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Message sent successfully via SMS"