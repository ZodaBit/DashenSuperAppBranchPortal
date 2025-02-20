Feature: Merchant Pagination Functionality

  Scenario: 1. Paginate through customer and retrieve the correct number of customer without any parameters
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I call the GET endpoint "ep_customer_paginate" without any pagination parameters
    Then the response status code should be 200
    And the response should have the header "Content-Type" set to "application/json; charset=utf-8"
    And the response should contain exactly 10 items in the "docs" field

  Scenario Outline: 2. Paginate through customer and retrieve the correct number of customer per page
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I call GET "ep_customer_paginate" with pagination parameters
      | limit | <limit> |
    Then the response status code should be 200
    And the response should contain exactly <limit> items in the "docs" field
    Examples:
      | limit |
      | 1     |
      | 5     |
      | 100   |
