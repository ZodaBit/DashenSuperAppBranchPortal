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
      | search_key | MPSA671419142764334 |
    Then the response status code should be 200
    And the response should contain a field named "data[0].serial_number" with the value "16311"
    And the response should contain a field named "data[0].trxID" with the value "MPSA671419142764334"
    And the response should contain a field named "data[0].user_code" with the value "14996475762295"
    And the response should contain a field named "data[0].phone_number" with the value "+251924371431"
    And the response should contain a field named "data[0].ft_number" with the value "015MPSA2316604gL"
    And the response should contain a field named "data[0].debit_account" with the value "5015910659001"
    And the response should contain a field named "data[0].debit_name" with the value "BELAY DORI BOROJI"
    And the response should contain a field named "data[0].credit_account" with the value "0001891890009"
    And the response should contain a field named "data[0].credit_name" with the value "MULTICHOICE ETHIOPIA PLC FOR MULTICHOICE AFRICA SUBSCRIPTION"
    And the response should contain a field named "data[0].credit_phonenumber" with the value ""
    And the response should contain a field named "data[0].transaction_type" with the value "MERCHANT"
    And the response should contain a field named "data[0].transaction_status" with the value "PAID"
    And the response should contain a field named "data[0].reason" with the value "Merchant Payment"
    And the response should contain a field named "data[0].payment_method" with the value "QR"
    And the response should contain a field named "data[0].amount" with the value "14"
    And the response should contain a field named "data[0].tip" with the value "0"
    And the response should contain a field named "data[0].paid_amount" with the value "14"
    And the response should contain a field named "data[0].service_fee" with the value "1"
    And the response should contain a field named "data[0].vat" with the value "0.15"
    And the response should contain a field named "data[0].currency" with the value "ETB"
    And the response should contain a field named "data[0].bank_name" with the value "Dashen Bank SC"
    And the response should contain a field named "data[0].paidAt" with the value "2025-03-05T11:57:19.014Z"
    And the response should contain a field named "data[0].createdAt" with the value "2025-03-05T11:57:15.179Z"
    And the response should contain a field named "data[0].updatedAt" with the value "2025-03-05T11:57:19.018Z"
    And the response should contain a field named "data[0].businessId" with the value "67a308b06d9af584c5aa7ad8"
    And the response should contain a field named "data[0].bcicode" with the value "null"
    And the response should contain a field named "data[0].till_number" with the value "3356453"
    And the response should contain a field named "data[0].product_code" with the value "MPSA"
    And the response should contain a field named "data[0].service_fee_product_code" with the value "SMP"
    And the response should contain a field named "data[0].vat_product_code" with the value "VFM"
    And the response should contain a field named "data[0].is_mini_app" with the value "null"
    And the response should contain a field named "data[0].mini_app_name" with the value ""
    And the response should contain a field named "data[0].mini_app_code" with the value ""


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