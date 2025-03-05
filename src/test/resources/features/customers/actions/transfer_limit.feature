Feature: Verifying Transfer Limit functionality

  Scenario Outline: 1. Verifying Transaction Limit Rejection When One-Time Limit Exceeds Daily Limit
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_transfer_limit_otp_maker" with user code "<userCode>"
    And I send a POST request to "ep_customer_action_transfer_limit_verify_otp_maker" to verify the OTP for the user code "<userCode>"
    And I set the transaction limits for user "<userCode>", service "<serviceName>", one-time limit "<oneTimeLimit>", and daily limit "<dailyLimit>" as a maker
    Then the response status code should be 400
    And the response should contain a field named "message" with the value "Transaction one-time limit cannot be greater than the daily transaction limit"
    Examples:
      | userCode       | serviceName            | dailyLimit | oneTimeLimit |
      | 67572905475505 | merchant_pay           | 10000      | 500000       |
      | 67572905475505 | transfer_to_dashen     | 10000      | 500000       |
      | 67572905475505 | mpesa                  | 10000      | 500000       |
      | 67572905475505 | telebirr               | 10000      | 500000       |
      | 67572905475505 | transfer_to_own        | 10000      | 500000       |
      | 67572905475505 | member_accept_request  | 10000      | 500000       |
      | 67572905475505 | school_fee_payment     | 10000      | 500000       |
      | 67572905475505 | airline_ticket_payment | 10000      | 500000       |
      | 67572905475505 | safaricom_topup        | 10000      | 500000       |
      | 67572905475505 | ethiotelecom_topup     | 10000      | 500000       |
      | 67572905475505 | awach_payment          | 10000      | 500000       |
      | 67572905475505 | sahay_pay              | 10000      | 500000       |
      | 67572905475505 | lock_kazna             | 10000      | 500000       |
      | 67572905475505 | unlock_kazna           | 10000      | 500000       |
      | 67572905475505 | dstv                   | 10000      | 500000       |
      | 67572905475505 | vehicle_parking        | 10000      | 500000       |
      | 67572905475505 | traffic_penalty        | 10000      | 500000       |
      | 67572905475505 | guzogo                 | 10000      | 500000       |
      | 67572905475505 | teletv                 | 10000      | 500000       |
      | 67572905475505 | transfer_to_other_bank | 10000      | 500000       |

  Scenario Outline: 2. Verifying Transaction Limit Denial Process as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_transfer_limit_otp_maker" with user code "<userCode>"
    And I send a POST request to "ep_customer_action_transfer_limit_verify_otp_maker" to verify the OTP for the user code "<userCode>"
    And I set the transaction limits for user "<userCode>", service "<serviceName>", one-time limit "<oneTimeLimit>", and daily limit "<dailyLimit>" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Transaction limit update proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "DENIED" status transfer limit change request for user code "<userCode>" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Transaction limit update request denied"
    Examples:
      | userCode       | serviceName            | oneTimeLimit | dailyLimit |
      | 67572905475505 | merchant_pay           | 10000        | 500000     |
      | 67572905475505 | transfer_to_dashen     | 10000        | 500000     |
      | 67572905475505 | mpesa                  | 10000        | 500000     |
      | 67572905475505 | telebirr               | 10000        | 500000     |
      | 67572905475505 | transfer_to_own        | 10000        | 500000     |
      | 67572905475505 | member_accept_request  | 10000        | 500000     |
      | 67572905475505 | school_fee_payment     | 10000        | 500000     |
      | 67572905475505 | airline_ticket_payment | 10000        | 500000     |
      | 67572905475505 | safaricom_topup        | 10000        | 500000     |
      | 67572905475505 | ethiotelecom_topup     | 10000        | 500000     |
      | 67572905475505 | awach_payment          | 10000        | 500000     |
      | 67572905475505 | sahay_pay              | 10000        | 500000     |
      | 67572905475505 | lock_kazna             | 10000        | 500000     |
      | 67572905475505 | unlock_kazna           | 10000        | 500000     |
      | 67572905475505 | dstv                   | 10000        | 500000     |
      | 67572905475505 | vehicle_parking        | 10000        | 500000     |
      | 67572905475505 | traffic_penalty        | 10000        | 500000     |
      | 67572905475505 | guzogo                 | 10000        | 500000     |
      | 67572905475505 | teletv                 | 10000        | 500000     |
      | 67572905475505 | transfer_to_other_bank | 10000        | 500000     |

  Scenario Outline:3. Verifying Authorization of Transaction Limit Process as Maker and Checker
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Abc@123"
    When I send a POST request to "ep_customer_action_transfer_limit_otp_maker" with user code "<userCode>"
    And I send a POST request to "ep_customer_action_transfer_limit_verify_otp_maker" to verify the OTP for the user code "<userCode>"
    And I set the transaction limits for user "<userCode>", service "<serviceName>", one-time limit "<oneTimeLimit>", and daily limit "<dailyLimit>" as a maker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Transaction limit update proposed, pending checker approval"

    Given I have a valid access token for the user "bini2"
    And I send a POST request to "ep_user_passcode_login" with the passcode "Admin@7"
    When I review the "AUTHORIZED" status transfer limit change request for user code "<userCode>" as a checker
    Then the response status code should be 200
    And the response should contain a field named "message" with the value "Transaction limit updated successfully"
    Examples:
      | userCode       | serviceName            | oneTimeLimit | dailyLimit |
      | 67572905475505 | merchant_pay           | 10000        | 500000     |
      | 67572905475505 | transfer_to_dashen     | 10000        | 500000     |
      | 67572905475505 | mpesa                  | 10000        | 500000     |
      | 67572905475505 | telebirr               | 10000        | 500000     |
      | 67572905475505 | transfer_to_own        | 10000        | 500000     |
      | 67572905475505 | member_accept_request  | 10000        | 500000     |
      | 67572905475505 | school_fee_payment     | 10000        | 500000     |
      | 67572905475505 | airline_ticket_payment | 10000        | 500000     |
      | 67572905475505 | safaricom_topup        | 10000        | 500000     |
      | 67572905475505 | ethiotelecom_topup     | 10000        | 500000     |
      | 67572905475505 | awach_payment          | 10000        | 500000     |
      | 67572905475505 | sahay_pay              | 10000        | 500000     |
      | 67572905475505 | lock_kazna             | 10000        | 500000     |
      | 67572905475505 | unlock_kazna           | 10000        | 500000     |
      | 67572905475505 | dstv                   | 10000        | 500000     |
      | 67572905475505 | vehicle_parking        | 10000        | 500000     |
      | 67572905475505 | traffic_penalty        | 10000        | 500000     |
      | 67572905475505 | guzogo                 | 10000        | 500000     |
      | 67572905475505 | teletv                 | 10000        | 500000     |
      | 67572905475505 | transfer_to_other_bank | 10000        | 500000     |