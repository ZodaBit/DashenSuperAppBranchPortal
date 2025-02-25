Feature: Transactions Pagination Functionality

  Scenario: 1. Paginate through transactions and retrieve the correct number of transactions without any parameters
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I call the GET endpoint "ep_transactions_paginate" without any pagination parameters
    Then the response status code should be 200
    And the response should have the header "Content-Type" set to "application/json; charset=utf-8"
    And the response should contain exactly 10 items in the "data" field

  Scenario Outline: 2. Paginate through transactions and retrieve the correct number of transactions per page
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I call GET "ep_transactions_paginate" with pagination parameters
      | limit | <limit> |
    Then the response status code should be 200
    And the response should contain exactly <limit> items in the "data" field
    Examples:
      | limit |
      | 1     |
      | 5     |
      | 40    |
