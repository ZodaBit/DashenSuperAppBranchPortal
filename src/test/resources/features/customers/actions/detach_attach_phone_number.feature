Feature: Phone Number Attachment and Detachment Actions Functionality


  Scenario: 1. Verify Detach Phone Number Denied Action as a maker and a checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_detach_phone_number_otp" with user code "129676245406479"
    And I attempt to Detach the phone number using the user code "129676245406479" and phone number "+251921069701" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "detach phone proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the detach phone number "+251921069701" change request for the user code "129676245406479" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account detachment denied"

  Scenario: 2. Verify Detach Phone Number AUTHORIZED Action as a maker and a checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_detach_phone_number_otp" with user code "129676245406479"
    And I attempt to Detach the phone number using the user code "129676245406479" and phone number "+251921069701" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "detach phone proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the detach phone number "+251921069701" change request for the user code "129676245406479" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "phone detached and user duplicated successfully"

  Scenario: 3. Verify Attach Phone Number Denied Action as a maker and a checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_attach_phone_number_otp_maker" with user code "129676245406479" and phone number "+251921069701"
    And I attempt to Attach the phone number using the user code "129676245406479" and phone number "+251921069701" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account attaching proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the attach phone number "+251921069701" change request for the user code "129676245406479" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account detachment denied"

  Scenario: 4. Verify Attach Phone Number AUTHORIZED Action as a maker and a checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_attach_phone_number_otp_maker" with user code "129676245406479" and phone number "+251921069701"
    And I attempt to Attach the phone number using the user code "129676245406479" and phone number "+251921069701" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account attaching proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the attach phone number "+251921069701" change request for the user code "129676245406479" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account attached successfully"