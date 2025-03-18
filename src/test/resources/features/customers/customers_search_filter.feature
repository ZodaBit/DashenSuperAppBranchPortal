Feature: Customer Search API Validation

  Scenario: 1. Search for customers account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | searchKey | 5019007165031 |
    Then the response status code should be 200
    And each item in the response body should have "docs.mainAccount" field set to "5019007165031"
    And each item in the response body should have "docs.fullName" field set to "mikias antonachi micheal s/a"

  Scenario: 2. Search for customers using name
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | searchKey | emebet workugebrekidan |
    Then the response status code should be 200
    And each item in the response body should have "docs.fullName" field set to "emebet workugebrekidan"

  Scenario Outline: 3. Search for customers using phone number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | searchKey | <phoneNumber> |
    Then the response status code should be 200
    And each item in the response body should have "docs.phoneNumber" field set to "+251901430173"
    And each item in the response body should have "docs.fullName" field set to "matias getachew kibeb"
    Examples:
      | phoneNumber   |
      | 251901430173  |
      | 901430173     |
      | +251901430173 |

  Scenario Outline: 4. Filter customers using branch status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | status | <BranchStatus> |
    Then the response status code should be 200
    And each item in the response body should have "docs.LDAPStatus" field set to "<BranchStatus>"
    Examples:
      | BranchStatus |
      | PENDING      |
      | AUTHORIZED   |
      | DENIED       |
      | INITIATED    |