Feature: Merchant Search API Validation

  Scenario: 1. Search for merchant account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | search_key | 0518343016011 |
    Then the response status code should be 200
    And each item in the response body should have "docs.accountNumber" field set to "0518343016011"
    And each item in the response body should have "docs.businessName" field set to "haile hotel"
    And each item in the response body should have "docs.phoneNumber" field set to "+251988737619"
    And each item in the response body should have "docs.accountHolderName" field set to "HAILE AND ALEM INTERNATIONAL PLC"

  Scenario: 2. Search for merchant using name
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | search_key | ABC trading |
    Then the response status code should be 200
    And each item in the response body should have "docs.businessName" field set to "ABC trading "
    And each item in the response body should have "docs.phoneNumber" field set to "+251906240024"
    And each item in the response body should have "docs.accountNumber" field set to "2900265365811"
    And each item in the response body should have "docs.accountHolderName" field set to "ABDU KEDIR DEGU"

  Scenario: 3. Search for merchant using phone number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | search_key | 251947373253 |
    Then the response status code should be 200
    And each item in the response body should have "docs.phoneNumber" field set to "+251947373253"
    And each item in the response body should have "docs.businessName" field set to "Galaxy Advertising"
    And each item in the response body should have "docs.accountNumber" field set to "5219001008008"
    And each item in the response body should have "docs.accountHolderName" field set to "SEMHAR MEBRAHATU  ARFAYNE"

  Scenario Outline: 4. Filter merchant by Authorized status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | status | <status> |
    Then the response status code should be 200
    And each item in the response body should have "docs.LDAPStatus" field set to "<status>"
    Examples:
      | status     |
      | AUTHORIZED |
      | DENIED     |
      | PENDING    |
