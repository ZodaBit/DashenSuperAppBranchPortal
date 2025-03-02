Feature: Change Phone Number Actions Functionality


  Scenario: 1. Change Phone Number Action Without OTP Option and Using an Existing Phone Number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I attempt to change the phone number using the user code "52721867126714" and phone number "+251901430173" as a maker
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "Customer with this Phone number already exists."

  Scenario: 2. Verify Change Phone Number Action Without OTP Option and Current Phone number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I attempt to change the phone number using the user code "52721867126714" and phone number "+251799117172" as a maker
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "You cannot change your Phone number to your current phone number. Please enter a different one."

  Scenario: 3. Verify Change Phone Number Action With OTP Option and Using an Existing Phone Number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I retrieve and verify the OTP for the user code "123085832085002"
    And the response should contain a field named "message" with the value "OTP verified successfully"
    When I attempt to change the phone number using the user code "123085832085002" and phone number "+251901430173" as a maker
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "Customer with this Phone number already exists."


  Scenario: 4. Verify Change Phone Number Denied Action as a maker and a checker With OTP option and a Valid Phone Number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I retrieve and verify the OTP for the user code "123085832085002"
    And the response should contain a field named "message" with the value "OTP verified successfully"
    And I attempt to change the phone number using the user code "123085832085002" and phone number "+251912717278" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP verified successfully. Awaiting approval for phone number change."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the phone number "+251912717278" change request for the user code "123085832085002" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "phone number change declined"

  Scenario: Verify Change Phone Number Denied Action as a maker and a checker Without OTP option and a Valid Phone Number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I attempt to change the phone number using the user code "123085832085002" and phone number "+251912717278" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP verified successfully. Awaiting approval for phone number change."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the phone number "+251912717278" change request for the user code "123085832085002" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "phone number change declined"

  Scenario: Verify Change Phone Number AUTHORIZED Action as a maker and a checker Without OTP option and a Valid Phone Number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I attempt to change the phone number using the user code "52721867126714" and phone number "+251799117172" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "OTP verified successfully. Awaiting approval for phone number change."

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the phone number "+251799117172" change request for the user code "52721867126714" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Phone number changed successfully"