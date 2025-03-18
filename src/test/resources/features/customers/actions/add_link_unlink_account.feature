Feature: Add, Link, and Unlink Account Actions Functionality

  Scenario: 1. Verifying adding an existing account number with a different branch type
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_lookup_maker" with the account number "2928165391711"
    And I send a POST request to "ep_customer_action_account_lookup_otp" with user code "86542002667596" and account number "2928165391711"
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "account branch type mismatch you can't link this account in this branch"

  Scenario: 2. Verifying Account Unlinking  DENIED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_Action_account_unlink_otp_maker" with user code "189426946377" and account number "5189001010001"
    And I attempt to unlink account number using the user code "189426946377" and account number "5189001010001" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account unlinking proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the unlink account number "5189001010001" change request for the user code "189426946377" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account unlinking declined"

  Scenario: 3. Verifying Account Unlinking  AUTHORIZED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_Action_account_unlink_otp_maker" with user code "189426946377" and account number "5189001010001"
    And I attempt to unlink account number using the user code "189426946377" and account number "5189001010001" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account unlinking proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the unlink account number "5189001010001" change request for the user code "189426946377" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account unlinked successfully"

  Scenario: 4. Verifying Account linking  DENIED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_lookup_maker" with the account number "5189001010001"
    When I send a POST request to "ep_customer_Action_account_link_otp_maker" with user code "189426946377" and account number "5189001010001"
    And I attempt to link account number using the user code "189426946377" and account number "5189001010001" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account linking proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the link account number "5189001010001" change request for the user code "189426946377" with status "DENIED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account linking declined"

  Scenario: 5. Verifying Account linking  AUTHORIZED Process action as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_account_lookup_maker" with the account number "5189001010001"
    When I send a POST request to "ep_customer_Action_account_link_otp_maker" with user code "189426946377" and account number "5189001010001"
    And I attempt to link account number using the user code "189426946377" and account number "5189001010001" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Account linking proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the link account number "5189001010001" change request for the user code "189426946377" with status "AUTHORIZED" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Message sent successfully via SMS"

