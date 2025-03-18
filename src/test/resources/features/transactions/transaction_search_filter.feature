Feature: Transactions Search API Validation

  Scenario: 1. Search for transactions account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | search_key | 5004907881071 |
    Then the response status code should be 200
    And the response "data" should contain one or more items


  Scenario: 2. Search for transactions using sender name
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | search_key | MIKIAS |
    Then the response status code should be 200
    And the response "data" should contain one or more items

  Scenario: 3. Search for transactions using transaction Id
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | search_key | TPPS33184594554293292565 |
    Then the response status code should be 200
    And the response should contain a field named "data[0].trxID" with the value "TPPS33184594554293292565"
    And the response should contain a field named "data[0].user_code" with the value "14548154329054"
    And the response should contain a field named "data[0].phone_number" with the value "+251936036099"

  Scenario: 4. Filter transactions using branch status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | status | PAID |
    Then the response status code should be 200
    And each item in the response body should have "data.transaction_status" field set to "PAID"

  Scenario Outline: 5. Filter transactions using Type
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | type | <TransactionType> |
    Then the response status code should be 200
    And each item in the response body should have "data.transaction_type" field set to "<TransactionType>"
    Examples:
      | TransactionType |
      | OTHERBANK       |
      | DASHEN          |
      | REQUEST         |
      | CHAT            |
      | WALLET          |
      | MINIAPP         |
      | MERCHANT        |
      | TOPUP           |

  Scenario: 6. Filter transactions using Utility
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | type | UTILITY |
    Then the response status code should be 200
    And each item in the response body should have "data.transaction_type" field set to "Bill Payment"

  Scenario: 7. Filter transactions using a date later than the given date
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to | 2025-01-10 |
    Then the response status code should be 200
    And the "data.paidAt" response should not contain a date later than "2026-01-10"

  Scenario: 8. Filter transactions using a date earlier than the given date
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to | 2025-01-10 |
    Then the response status code should be 200
    And the "data.paidAt" response should not contain a date earlier than "2025-01-08"

  Scenario: 9. Filter transactions using a date within the valid range
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to   | 2025-02-10 |
      | date_from | 2025-02-01 |
    Then the response status code should be 200
    And the "data.paidAt" response should not contain a date earlier than "2025-01-08"
    And the "data.paidAt" response should contain a date within the valid range from "2025-02-01" to "2025-02-11"

  Scenario: 10. Verify every transaction has a valid pid status and product code
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I make a GET request to "ep_transactions_paginate" to fetch all transactions
    Then the response status code should be 200
    And each item in the response body should not have the field "data.transaction_status" set to "null"
    And each item in the response body should not have the field "data.transaction_status" set to "failed"
    And each item in the response body should not have the field "data.transaction_status" set to "pending"
#    And each item in the response body should not have the field "data.product_code" set to ""
#    And each item in the response body should not have the field "data.product_code" set to "null"






