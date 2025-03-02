Feature: Customer Search API Validation

  Scenario: 1. Search for customers account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | searchKey | 5019007165021 |
    Then the response status code should be 200
    And the response should contain exactly 1 items in the "docs" field
    And the response should contain a field named "docs[0].fullName" with the value "mikias antonachi micheal s/a"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251901430173"
    And the response should contain a field named "docs[0].mainAccount" with the value "5019007165031"
    And the response should contain a field named "docs[0].linkedAccounts[0].accountNumber" with the value "5019007165021"
    And the response should contain a field named "docs[0].linkedAccounts[0].linkedStatus" with the value "true"
    And the response should contain a field named "docs[0].linkedAccounts[1].accountNumber" with the value "5019007165031"
    And the response should contain a field named "docs[0].linkedAccounts[1].linkedStatus" with the value "true"
    And the response should contain a field named "docs[0].linkedAccounts[2].accountNumber" with the value "5019007165111"
    And the response should contain a field named "docs[0].linkedAccounts[2].linkedStatus" with the value "true"
    And the response should contain a field named "docs[0].KYCStatus" with the value "APPROVED"
    And the response should contain a field named "docs[0].customerNumber" with the value "019007165"

  Scenario: 2. Search for customers using name
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | searchKey | emebet workugebrekidan |
    Then the response status code should be 200
    And the response should contain exactly 1 items in the "docs" field
    And the response should contain a field named "docs[0].fullName" with the value "emebet workugebrekidan"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251936633529"
    And the response should contain a field named "docs[0].mainAccount" with the value "5015903528001"
    And the response should contain a field named "docs[0].linkedAccounts[0].accountNumber" with the value "5015903528001"
    And the response should contain a field named "docs[0].linkedAccounts[0].linkedStatus" with the value "true"
    And the response should contain a field named "docs[0].linkedAccounts[1].accountNumber" with the value "5015903528101"
    And the response should contain a field named "docs[0].linkedAccounts[1].linkedStatus" with the value "true"
    And the response should contain a field named "docs[0].KYCStatus" with the value "APPROVED"
    And the response should contain a field named "docs[0].customerNumber" with the value "015903528"

  Scenario:3. Search for customers using phone number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | searchKey | 251901430173 |
    Then the response status code should be 200
    And the response should contain exactly 1 items in the "docs" field
    And the response should contain a field named "docs[0].fullName" with the value "mikias antonachi micheal s/a"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251901430173"
    And the response should contain a field named "docs[0].mainAccount" with the value "5019007165031"
    And the response should contain a field named "docs[0].customerNumber" with the value "019007165"


  Scenario Outline: 4.  Filter customers using branch status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_customer_paginate" with the following query parameter:
      | status    | <BranchStatus> |
      | searchKey | <PhoneNumber>  |
    Then the response status code should be 200
    And the response should contain a field named "docs[0].fullName" with the value "<Name>"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+<PhoneNumber>"
    And the response should contain a field named "docs[0].accountLinked" with the value "<LinkedStatus>"
    Examples:
      | BranchStatus | LinkedStatus | Name                      | PhoneNumber  |
      | PENDING      | true         | rihana workineh wako      | 251911336496 |
      | AUTHORIZED   | true         | fentanesh tiruneh workneh | 251970289395 |
      | DENIED       | true         | emebet workugebrekidan    | 251936633529 |
      | INITIATED    | false        | RIAD DEMMAJ GAZEM         | 251705100810 |

