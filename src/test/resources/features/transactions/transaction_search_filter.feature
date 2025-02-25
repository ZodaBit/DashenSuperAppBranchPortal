Feature: Transactions Search API Validation

#  Scenario: 1. Search for transactions account number
#    Given I have a valid access token for the user "zolam"
#    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
#    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
#      | search_key | 5015903528001 |
#    Then the response status code should be 200
#    And the response should contain a field named "data[5].serial_number" with the value "15598"
#    And the response should contain a field named "data[5].trxID" with the value "WDTS11434357045277244222"
#    And the response should contain a field named "data[5].user_code" with the value "1157558038223"
#    And the response should contain a field named "data[5].phone_number" with the value "+251936633529"
#    And the response should contain a field named "data[5].ft_number" with the value "015WDTS23166037j"
#    And the response should contain a field named "data[5].debit_account" with the value "5015903528001"
#    And the response should contain a field named "data[5].debit_name" with the value "EMEBET WORKUGEBREKIDAN"
#    And the response should contain a field named "data[5].credit_account" with the value "+251911554491"
#    And the response should contain a field named "data[5].credit_name" with the value "PAUL RIES AND SONS ETHIOPIA LIMITED COMPANY"
#    And the response should contain a field named "data[5].credit_phonenumber" with the value "+251911554491"
#    And the response should contain a field named "data[5].transaction_type" with the value "CHAT"
#    And the response should contain a field named "data[5].reason" with the value "SuperAPP - Chat Send Money"
#    And the response should contain a field named "data[5].payment_method" with the value "CHAT"
#    And the response should contain a field named "data[5].amount" with the value "10"
#    And the response should contain a field named "data[5].tip" with the value "0"
#    And the response should contain a field named "data[5].paid_amount" with the value "10"
#    And the response should contain a field named "data[5].service_fee" with the value "0"
#    And the response should contain a field named "data[5].vat" with the value "0"
#    And the response should contain a field named "data[5].currency" with the value "ETB"
#    And the response should contain a field named "data[5].bank_name" with the value "Dashen Bank SC"
#    And the response should contain a field named "data[5].product_code" with the value "WDTS"
#    And the response should contain a field named "data[5].service_fee_product_code" with the value "SFD"
#    And the response should contain a field named "data[5].vat_product_code" with the value "VFD"
#    And the response should contain a field named "data[5].paidAt" with the value "2025-02-21T07:01:04.940Z"
#    And the response should contain a field named "data[5].createdAt" with the value "2025-02-21T07:01:03.577Z"
#    And the response should contain a field named "data[5].updatedAt" with the value "2025-02-21T07:01:04.948Z"
#
#
#  Scenario: 2. Search for transactions using sender name
#    Given I have a valid access token for the user "zolam"
#    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
#    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
#      | search_key | belay dori boroji |
#    Then the response status code should be 200
#    And the response should contain a field named "data[0].serial_number" with the value "15590"
#    And the response should contain a field named "data[0].trxID" with the value "TASA10884995751606065633"
#    And the response should contain a field named "data[0].user_code" with the value "14996475762295"
#    And the response should contain a field named "data[0].phone_number" with the value "+251991014552"
#    And the response should contain a field named "data[0].ft_number" with the value "015TASA23166012Z"
#    And the response should contain a field named "data[0].debit_account" with the value "5015910659001"
#    And the response should contain a field named "data[0].debit_name" with the value "belay dori boroji"
#    And the response should contain a field named "data[0].credit_account" with the value "5237447861011"
#    And the response should contain a field named "data[0].credit_name" with the value "Awach SACCOS"
#    And the response should contain a field named "data[0].credit_phonenumber" with the value ""
#    And the response should contain a field named "data[0].transaction_type" with the value "AWACH"
#    And the response should contain a field named "data[0].reason" with the value "Awach SACCOS"
#    And the response should contain a field named "data[0].payment_method" with the value "null"
#    And the response should contain a field named "data[0].amount" with the value "55"
#    And the response should contain a field named "data[0].tip" with the value "0"
#    And the response should contain a field named "data[0].paid_amount" with the value "null"
#    And the response should contain a field named "data[0].service_fee" with the value "3"
#    And the response should contain a field named "data[0].vat" with the value "0.45"
#    And the response should contain a field named "data[0].currency" with the value "ETB"
#    And the response should contain a field named "data[0].bank_name" with the value "DASHEN"
#    And the response should contain a field named "data[0].product_code" with the value "TASA"
#    And the response should contain a field named "data[0].service_fee_product_code" with the value "STA"
#    And the response should contain a field named "data[0].vat_product_code" with the value "VTA"
#    And the response should contain a field named "data[0].paidAt" with the value "2025-02-20T15:45:28.854Z"
#    And the response should contain a field named "data[0].createdAt" with the value "2025-02-20T15:45:27.454Z"
#    And the response should contain a field named "data[0].updatedAt" with the value "2025-02-20T15:45:28.854Z"
#
#
#  Scenario: 3. Search for transactions using transaction Id
#    Given I have a valid access token for the user "zolam"
#    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
#    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
#      | search_key | ASSA10847241582497847664 |
#    Then the response status code should be 200
#    And the response should contain a field named "data[0].serial_number" with the value "15587"
#    And the response should contain a field named "data[0].trxID" with the value "ASSA10847241582497847664"
#    And the response should contain a field named "data[0].user_code" with the value "72758708821132"
#    And the response should contain a field named "data[0].phone_number" with the value "+251901430173"
#    And the response should contain a field named "data[0].ft_number" with the value "126ASSA23166000H"
#    And the response should contain a field named "data[0].debit_account" with the value "5019007165031"
#    And the response should contain a field named "data[0].debit_name" with the value "MIKIAS ANTONACHI MICHEAL"
#    And the response should contain a field named "data[0].credit_account" with the value "5020917312031"
#    And the response should contain a field named "data[0].credit_name" with the value "Adika"
#    And the response should contain a field named "data[0].credit_phonenumber" with the value ""
#    And the response should contain a field named "data[0].transaction_type" with the value "MINIAPP"
#    And the response should contain a field named "data[0].transaction_status" with the value "PAID"
#    And the response should contain a field named "data[0].reason" with the value "Top Up Account"
#    And the response should contain a field named "data[0].payment_method" with the value "Dashen Super App"
#    And the response should contain a field named "data[0].amount" with the value "100"
#    And the response should contain a field named "data[0].tip" with the value "0"
#    And the response should contain a field named "data[0].paid_amount" with the value "100"
#    And the response should contain a field named "data[0].service_fee" with the value "0"
#    And the response should contain a field named "data[0].vat" with the value "0"
#    And the response should contain a field named "data[0].currency" with the value "ETB"
#    And the response should contain a field named "data[0].bank_name" with the value "Dashen Bank"
#    And the response should contain a field named "data[0].paidAt" with the value "2025-02-20T14:42:33.389Z"
#    And the response should contain a field named "data[0].createdAt" with the value "2025-02-20T14:42:32.031Z"
#    And the response should contain a field named "data[0].updatedAt" with the value "2025-02-20T14:42:33.389Z"
#    And the response should contain a field named "data[0].businessId" with the value "null"
#    And the response should contain a field named "data[0].bcicode" with the value "231405"
#    And the response should contain a field named "data[0].product_code" with the value "ASSA"
#    And the response should contain a field named "data[0].service_fee_product_code" with the value "ASA"
#    And the response should contain a field named "data[0].vat_product_code" with the value "VAP"
#    And the response should contain a field named "data[0].is_mini_app" with the value "true"
#    And the response should contain a field named "data[0].mini_app_name" with the value "Adika"
#    And the response should contain a field named "data[0].mini_app_code" with the value "726556"
#
#
#  Scenario Outline: 4.  Filter transactions using branch status
#    Given I have a valid access token for the user "zolam"
#    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
#    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
#      | status | <Status> |
#    Then the response status code should be 200
#    And the response should contain a field named "data[0].trxID" with the value "<TrxID>"
#    And the response should contain a field named "data[0].product_code" with the value "<ProductCode>"
#    And the response should contain a field named "data[0].debit_name" with the value "<DebitName>"
#    And the response should contain a field named "data[0].debit_account" with the value "<DebitAccount>"
#    And the response should contain a field named "data[0].transaction_type" with the value "<TransactionType>"
#    And the response should contain a field named "data[0].credit_name" with the value "<CreditName>"
#    And the response should contain a field named "data[0].credit_account" with the value "<CreditAccount>"
#    And the response should contain a field named "data[0].phone_number" with the value "<PhoneNumber>"
#    And the response should contain a field named "data[0].bank_name" with the value "<BankName>"
#    And the response should contain a field named "data[0].amount" with the value "<Amount>"
#    And the response should contain a field named "data[0].service_fee" with the value "<ServiceFee>"
#    And the response should contain a field named "data[0].service_fee_product_code" with the value "<ServiceFeeProductCode>"
#    And the response should contain a field named "data[0].vat_product_code" with the value "<VatProductCode>"
#    And the response should contain a field named "data[0].currency" with the value "<Currency>"
#    And the response should contain a field named "data[0].ft_number" with the value "<FtNumber>"
#    And the response should contain a field named "data[0].transaction_status" with the value "<TransactionStatus>"
#
#    Examples:
#      | Status | TrxID                    | ProductCode | DebitName              | DebitAccount  | TransactionType | CreditName           | CreditAccount | PhoneNumber   | BankName       | Amount | ServiceFee | ServiceFeeProductCode | VatProductCode | Currency | FtNumber         | TransactionStatus |
#      | PAID   | WDTS11481664905955703365 | WDTS        | EMEBET WORKUGEBREKIDAN | 5015903528001 | CHAT            | BAHARU ALEMU NEGASHE | +251947002752 | +251936633529 | Dashen Bank SC | 11     | 0          | SFD                   | VFD            | ETB      | 015WDTS23166037p | PAID              |
#
#
#  Scenario Outline: 5.  Filter transactions using Type
#    Given I have a valid access token for the user "zolam"
#    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
#    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
#      | type | <Type> |
#    Then the response status code should be 200
#    And the response should contain a field named "data[0].trxID" with the value "<TrxID>"
#    And the response should contain a field named "data[0].product_code" with the value "<ProductCode>"
#    And the response should contain a field named "data[0].debit_name" with the value "<DebitName>"
#    And the response should contain a field named "data[0].debit_account" with the value "<DebitAccount>"
#    And the response should contain a field named "data[0].transaction_type" with the value "<TransactionType>"
#    And the response should contain a field named "data[0].credit_name" with the value "<CreditName>"
#    And the response should contain a field named "data[0].credit_account" with the value "<CreditAccount>"
#    And the response should contain a field named "data[0].phone_number" with the value "<PhoneNumber>"
#    And the response should contain a field named "data[0].bank_name" with the value "<BankName>"
#    And the response should contain a field named "data[0].amount" with the value "<Amount>"
#    And the response should contain a field named "data[0].service_fee" with the value "<ServiceFee>"
#    And the response should contain a field named "data[0].service_fee_product_code" with the value "<ServiceFeeProductCode>"
#    And the response should contain a field named "data[0].vat_product_code" with the value "<VatProductCode>"
#    And the response should contain a field named "data[0].currency" with the value "<Currency>"
#    And the response should contain a field named "data[0].ft_number" with the value "<FtNumber>"
#    And the response should contain a field named "data[0].transaction_status" with the value "<TransactionStatus>"
#    Examples:
#      | Type      | TrxID                    | ProductCode | DebitName                | DebitAccount  | TransactionType | CreditName            | CreditAccount | PhoneNumber   | BankName       | Amount | ServiceFee | ServiceFeeProductCode | VatProductCode | Currency | FtNumber         | TransactionStatus |
#      | OTHERBANK | OBTS11429933711683383251 | OBTS        | EYERUSE  TENI FONIZA     | 5019798591021 | OTHERBANK       | TimeOut test          | 131234567890  | +251933703329 | IPS Test Bank  | 100    | 0.1        | SFO                   | VOT            | ETB      | 126OBTS2316601Yu | PAID              |
#      | DASHEN    | WDTS11626155522929796723 | WDTS        | BAHARU ALEMU NEGASHE     | 5105004528008 | DASHEN          | TAKELE GIRMA CHEKOL   | 5020923018947 | +251947002752 | Dashen Bank    | 123    | 1          | SFD                   | VFD            | ETB      | 105WDTS2316601Z8 | PAID              |
#      | REQUEST   | MPSA10832281499893205603 |             | WONDIM FENTA MITKU       | 0031531652031 | REQUEST         | WONDIM FENTA MITKU    | 5031531652011 | +251926862255 | DASHEN BANK SC | 200    | 1          |                       |                | ETB      | 031MPSA231660134 | PAID              |
#      | CHAT      | WDTS11481664905955703365 | WDTS        | EMEBET WORKUGEBREKIDAN   | 5015903528001 | CHAT            | BAHARU ALEMU NEGASHE  | +251947002752 | +251936633529 | Dashen Bank SC | 11     | 0          | SFD                   | VFD            | ETB      | 015WDTS23166037p | PAID              |
#      | WALLET    | LMWS11614484458120473571 | LMWS        | BAHARU ALEMU NEGASHE     | 5105004528008 | WALLET          | Abel The Bazu         | +251700100141 | +251947002752 | Dashen Bank SC | 200    | 1          | SFM                   | VML            | ETB      | 105LMWS23166012X | PAID              |
#      | UTILITY   | DPSA2480444604765        | DPSA        | YIFRU TESFAYE TEFERA     | 5028004551001 | Bill Payment    | DSTV                  | 7036129544    | +251918539962 | Dashen Bank    | 2750   | 2          | SDP                   | VDP            | ETB      | 028DPSA2316600WM | PAID              |
#      | MINIAPP   | ASSA10847241582497847664 | ASSA        | MIKIAS ANTONACHI MICHEAL | 5019007165031 | MINIAPP         | Adika                 | 5020917312031 | +251901430173 | Dashen Bank    | 100    | 0          | ASA                   | VAP            | ETB      | 126ASSA23166000H | PAID              |
#      | MERCHANT  | MPSA696475804716201      | MPSA        | YIFRU TESFAYE TEFERA     | 5028004551001 | MERCHANT        | BRHANEA GEBRE ARAGAW  | 5047102110011 | +251918539962 | Dashen Bank SC | 250    | 1          | SMP                   | VFM            | ETB      | 028MPSA2316601Yv | PAID              |
#      | TOPUP     | ETAP10620487774171600643 | ETAP        | YIFRU TESFAYE TEFERA-    | 5028004551001 | TOPUP           | ETHIO TELECOM AIRTIME | +251918539962 | +251918539962 | Dashen Bank Sc | 5      | 0          | SET                   | VET            | ETB      | 028ETAP2316602bJ | PAID              |
#
##  Scenario : 6.  Filter transactions using date
##    Given I have a valid access token for the user "zolam"
##    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
##    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
##      | date_to | 2025-01-10 |
##    Then the response status code should be 200
##    And the "data" response should not contain a date later than "2025-01-10"
#    #And the "data" response should not contain a date earlier than "2020-09-09"
#    #And the "data" response should contain a date within the valid range from "4444-01-01" to "2025-12-31"

  Scenario: 6. Filter transactions using date
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_transactions_paginate" with the following query parameter:
      | date_to | 2025-01-10 |
    Then the response status code should be 200
    And the "data" response should not contain a date later than "2025-01-10"

