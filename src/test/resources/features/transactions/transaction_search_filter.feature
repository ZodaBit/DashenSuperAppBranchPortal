Feature: Transactions Search API Validation

  Scenario: 1. Search for transactions account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | search_key | 5015903528001 |
    Then the response status code should be 200
    And the response "data" should contain one or more items


  Scenario: 2. Search for transactions using sender name
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | search_key | belay dori boroji |
    Then the response status code should be 200
    And the response "data" should contain one or more items

  Scenario: 3. Search for transactions using transaction Id
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | search_key | ASSA10847241582497847664 |
    Then the response status code should be 200
    And the response should contain a field named "data[0].serial_number" with the value "15587"
    And the response should contain a field named "data[0].trxID" with the value "ASSA10847241582497847664"
    And the response should contain a field named "data[0].user_code" with the value "72758708821132"
    And the response should contain a field named "data[0].phone_number" with the value "+251901430173"
    And the response should contain a field named "data[0].ft_number" with the value "126ASSA23166000H"
    And the response should contain a field named "data[0].debit_account" with the value "5019007165031"
    And the response should contain a field named "data[0].debit_name" with the value "MIKIAS ANTONACHI MICHEAL"
    And the response should contain a field named "data[0].credit_account" with the value "5020917312031"
    And the response should contain a field named "data[0].credit_name" with the value "Adika"
    And the response should contain a field named "data[0].credit_phonenumber" with the value ""
    And the response should contain a field named "data[0].transaction_type" with the value "MINIAPP"
    And the response should contain a field named "data[0].transaction_status" with the value "PAID"
    And the response should contain a field named "data[0].reason" with the value "Top Up Account"
    And the response should contain a field named "data[0].payment_method" with the value "Dashen Super App"
    And the response should contain a field named "data[0].amount" with the value "100"
    And the response should contain a field named "data[0].tip" with the value "0"
    And the response should contain a field named "data[0].paid_amount" with the value "100"
    And the response should contain a field named "data[0].service_fee" with the value "0"
    And the response should contain a field named "data[0].vat" with the value "0"
    And the response should contain a field named "data[0].currency" with the value "ETB"
    And the response should contain a field named "data[0].bank_name" with the value "Dashen Bank"
    And the response should contain a field named "data[0].paidAt" with the value "2025-02-20T14:42:33.389Z"
    And the response should contain a field named "data[0].createdAt" with the value "2025-02-20T14:42:32.031Z"
    And the response should contain a field named "data[0].updatedAt" with the value "2025-02-20T14:42:33.389Z"
    And the response should contain a field named "data[0].businessId" with the value "null"
    And the response should contain a field named "data[0].bcicode" with the value "231405"
    And the response should contain a field named "data[0].product_code" with the value "ASSA"
    And the response should contain a field named "data[0].service_fee_product_code" with the value "ASA"
    And the response should contain a field named "data[0].vat_product_code" with the value "VAP"
    And the response should contain a field named "data[0].is_mini_app" with the value "true"
    And the response should contain a field named "data[0].mini_app_name" with the value "Adika"
    And the response should contain a field named "data[0].mini_app_code" with the value "726556"


  Scenario Outline: 4.  Filter transactions using branch status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | status     | <Status> |
      | search_key | <TrxID>  |
    Then the response status code should be 200
    And the response should contain a field named "data[0].trxID" with the value "<TrxID>"
    And the response should contain a field named "data[0].product_code" with the value "<ProductCode>"
    And the response should contain a field named "data[0].debit_name" with the value "<DebitName>"
    And the response should contain a field named "data[0].debit_account" with the value "<DebitAccount>"
    And the response should contain a field named "data[0].transaction_type" with the value "<TransactionType>"
    And the response should contain a field named "data[0].credit_name" with the value "<CreditName>"
    And the response should contain a field named "data[0].credit_account" with the value "<CreditAccount>"
    And the response should contain a field named "data[0].phone_number" with the value "<PhoneNumber>"
    And the response should contain a field named "data[0].bank_name" with the value "<BankName>"
    And the response should contain a field named "data[0].amount" with the value "<Amount>"
    And the response should contain a field named "data[0].service_fee" with the value "<ServiceFee>"
    And the response should contain a field named "data[0].service_fee_product_code" with the value "<ServiceFeeProductCode>"
    And the response should contain a field named "data[0].vat_product_code" with the value "<VatProductCode>"
    And the response should contain a field named "data[0].currency" with the value "<Currency>"
    And the response should contain a field named "data[0].ft_number" with the value "<FtNumber>"
    And the response should contain a field named "data[0].transaction_status" with the value "<TransactionStatus>"

    Examples:
      | Status | TrxID                    | ProductCode | DebitName              | DebitAccount  | TransactionType | CreditName           | CreditAccount | PhoneNumber   | BankName       | Amount | ServiceFee | ServiceFeeProductCode | VatProductCode | Currency | FtNumber         | TransactionStatus |
      | PAID   | WDTS11481664905955703365 | WDTS        | EMEBET WORKUGEBREKIDAN | 5015903528001 | CHAT            | BAHARU ALEMU NEGASHE | +251947002752 | +251936633529 | Dashen Bank SC | 11     | 0          | SFD                   | VFD            | ETB      | 015WDTS23166037p | PAID              |


  Scenario Outline: 5.  Filter transactions using Type
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | type       | <Type>  |
      | search_key | <TrxID> |
    Then the response status code should be 200
   # And Each item of repsonse by "data.trxId" should contain "<TrxID>"
    And the response should contain a field named "data[0].trxID" with the value "<TrxID>"
    And the response should contain a field named "data[0].product_code" with the value "<ProductCode>"
    And the response should contain a field named "data[0].debit_name" with the value "<DebitName>"
    And the response should contain a field named "data[0].debit_account" with the value "<DebitAccount>"
    And the response should contain a field named "data[0].transaction_type" with the value "<TransactionType>"
    And the response should contain a field named "data[0].credit_name" with the value "<CreditName>"
    And the response should contain a field named "data[0].credit_account" with the value "<CreditAccount>"
    And the response should contain a field named "data[0].phone_number" with the value "<PhoneNumber>"
    And the response should contain a field named "data[0].bank_name" with the value "<BankName>"
    And the response should contain a field named "data[0].amount" with the value "<Amount>"
    And the response should contain a field named "data[0].service_fee" with the value "<ServiceFee>"
    And the response should contain a field named "data[0].service_fee_product_code" with the value "<ServiceFeeProductCode>"
    And the response should contain a field named "data[0].vat_product_code" with the value "<VatProductCode>"
    And the response should contain a field named "data[0].currency" with the value "<Currency>"
    And the response should contain a field named "data[0].ft_number" with the value "<FtNumber>"
    And the response should contain a field named "data[0].transaction_status" with the value "<TransactionStatus>"

    Examples:
      | Type      | TrxID                    | ProductCode | DebitName                | DebitAccount  | TransactionType | CreditName            | CreditAccount | PhoneNumber   | BankName       | Amount | ServiceFee | ServiceFeeProductCode | VatProductCode | Currency | FtNumber         | TransactionStatus |
      | OTHERBANK | OBTS11429933711683383251 | OBTS        | EYERUSE  TENI FONIZA     | 5019798591021 | OTHERBANK       | TimeOut test          | 131234567890  | +251933703329 | IPS Test Bank  | 100    | 0.1        | SFO                   | VOT            | ETB      | 126OBTS2316601Yu | PAID              |
      | DASHEN    | WDTS11626155522929796723 | WDTS        | BAHARU ALEMU NEGASHE     | 5105004528008 | DASHEN          | TAKELE GIRMA CHEKOL   | 5020923018947 | +251947002752 | Dashen Bank    | 123    | 1          | SFD                   | VFD            | ETB      | 105WDTS2316601Z8 | PAID              |
      | REQUEST   | MPSA10832281499893205603 |             | WONDIM FENTA MITKU       | 0031531652031 | REQUEST         | WONDIM FENTA MITKU    | 5031531652011 | +251926862255 | DASHEN BANK SC | 200    | 1          |                       |                | ETB      | 031MPSA231660134 | PAID              |
      | CHAT      | WDTS11481664905955703365 | WDTS        | EMEBET WORKUGEBREKIDAN   | 5015903528001 | CHAT            | BAHARU ALEMU NEGASHE  | +251947002752 | +251936633529 | Dashen Bank SC | 11     | 0          | SFD                   | VFD            | ETB      | 015WDTS23166037p | PAID              |
      | WALLET    | LMWS11614484458120473571 | LMWS        | BAHARU ALEMU NEGASHE     | 5105004528008 | WALLET          | Abel The Bazu         | +251700100141 | +251947002752 | Dashen Bank SC | 200    | 1          | SFM                   | VML            | ETB      | 105LMWS23166012X | PAID              |
      | UTILITY   | DPSA2480444604765        | DPSA        | YIFRU TESFAYE TEFERA     | 5028004551001 | Bill Payment    | DSTV                  | 7036129544    | +251918539962 | Dashen Bank    | 2750   | 2          | SDP                   | VDP            | ETB      | 028DPSA2316600WM | PAID              |
      | MINIAPP   | ASSA10847241582497847664 | ASSA        | MIKIAS ANTONACHI MICHEAL | 5019007165031 | MINIAPP         | Adika                 | 5020917312031 | +251901430173 | Dashen Bank    | 100    | 0          | ASA                   | VAP            | ETB      | 126ASSA23166000H | PAID              |
      | MERCHANT  | MPSA696475804716201      | MPSA        | YIFRU TESFAYE TEFERA     | 5028004551001 | MERCHANT        | BRHANEA GEBRE ARAGAW  | 5047102110011 | +251918539962 | Dashen Bank SC | 250    | 1          | SMP                   | VFM            | ETB      | 028MPSA2316601Yv | PAID              |
      | TOPUP     | ETAP10620487774171600643 | ETAP        | YIFRU TESFAYE TEFERA-    | 5028004551001 | TOPUP           | ETHIO TELECOM AIRTIME | +251918539962 | +251918539962 | Dashen Bank Sc | 5      | 0          | SET                   | VET            | ETB      | 028ETAP2316602bJ | PAID              |

  Scenario: 6. Filter transactions using a date later than the given date
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to | 2025-01-10 |
    Then the response status code should be 200
    And the "data.paidAt" response should not contain a date later than "2026-01-10"


  Scenario: 7. Filter transactions using a date earlier than the given date
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to | 2025-01-10 |
    Then the response status code should be 200
    And the "data.paidAt" response should not contain a date earlier than "2025-01-08"

  Scenario: 8. Filter transactions using a date within the valid range
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to   | 2025-02-10 |
      | date_from | 2025-02-01 |
    Then the response status code should be 200
    And the "data.paidAt" response should not contain a date earlier than "2025-01-08"
    And the "data.paidAt" response should contain a date within the valid range from "2025-02-01" to "2025-02-11"