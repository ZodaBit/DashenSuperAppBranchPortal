Feature: Merchant Search API Validation

  Scenario: 1. Search for merchant account number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | search_key | 0518343016011 |
    Then the response status code should be 200
    And the response should contain exactly 1 items in the "docs" field
    And the response should contain a field named "docs[0].businessName" with the value "haile hotel"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251988737619"
    And the response should contain a field named "docs[0].accountNumber" with the value "0518343016011"
    And the response should contain a field named "docs[0].accountHolderName" with the value "HAILE AND ALEM INTERNATIONAL PLC"
    And the response should contain a field named "docs[0].licenseNumber" with the value "TR12333331"
    And the response should contain a field named "docs[0].TIN" with the value "1023569877"
    And the response should contain a field named "docs[0].region" with the value "Addis Ababa"
    And the response should contain a field named "docs[0].city" with the value "Addis Ababa"
    And the response should contain a field named "docs[0].zone" with the value "YEKA"
    And the response should contain a field named "docs[0].woreda" with the value "12"
    And the response should contain a field named "docs[0].kebele" with the value "12"
    And the response should contain a field named "docs[0].houseNumber" with the value "NA"

  Scenario: 2. Search for merchant using name
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | search_key | ABC trading |
    Then the response status code should be 200
    And the response should contain exactly 1 items in the "docs" field
    And the response should contain a field named "docs[0].businessName" with the value "ABC trading "
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251906240024"
    And the response should contain a field named "docs[0].accountNumber" with the value "2900265365811"
    And the response should contain a field named "docs[0].accountHolderName" with the value "ABDU KEDIR DEGU"
    And the response should contain a field named "docs[0].licenseNumber" with the value "002235689452"
    And the response should contain a field named "docs[0].TIN" with the value "0006253545"
    And the response should contain a field named "docs[0].region" with the value "Addis Ababa"
    And the response should contain a field named "docs[0].city" with the value "Addis Ababa"
    And the response should contain a field named "docs[0].zone" with the value "14"
    And the response should contain a field named "docs[0].woreda" with the value "05"
    And the response should contain a field named "docs[0].kebele" with the value "01"
    And the response should contain a field named "docs[0].houseNumber" with the value "NEW"

  Scenario: 3. Search for merchant using phone number
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | search_key | 251947373253 |
    Then the response status code should be 200
    And the response should contain exactly 1 items in the "docs" field
    And the response should contain a field named "docs[0].businessName" with the value "Galaxy Advertising"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251947373253"
    And the response should contain a field named "docs[0].accountNumber" with the value "5219001008008"
    And the response should contain a field named "docs[0].accountHolderName" with the value "SEMHAR MEBRAHATU  ARFAYNE"
    And the response should contain a field named "docs[0].licenseNumber" with the value "759632454"
    And the response should contain a field named "docs[0].TIN" with the value "4522846562"
    And the response should contain a field named "docs[0].region" with the value "Addis Ababa"
    And the response should contain a field named "docs[0].city" with the value "Addis Ababa"
    And the response should contain a field named "docs[0].zone" with the value "04"
    And the response should contain a field named "docs[0].woreda" with the value "04"
    And the response should contain a field named "docs[0].kebele" with the value "04"
    And the response should contain a field named "docs[0].houseNumber" with the value "544"

  Scenario: 4.  Filter merchant by Authorized status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | status | AUTHORIZED |
    Then the response status code should be 200
    And the response should contain a field named "docs[0].accountHolderName" with the value "ADIU COMMUNICATION SERVICE PRIVATE "
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251911256432"
    And the response should contain a field named "docs[0].businessName" with the value "bjf"

  Scenario: 5.  Filter merchant by DENIED status
    Given I have a valid access token for the user "zolam"
    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
      | status | DENIED |
    Then the response status code should be 200
    And the response should contain a field named "docs[0].accountHolderName" with the value "TAKELE GIRMA CHEKOL"
    And the response should contain a field named "docs[0].phoneNumber" with the value "+251911111111"
    And the response should contain a field named "docs[0].businessName" with the value "testm"


#  Scenario Outline: 6.  Filter customers by pending status
#    Given I have a valid access token for the user "zolam"
#    And I send a POST request to "ep_user_login" with the passcode "Abc@123"
#    When I send a GET request to "ep_merchant_paginate" with the following query parameter:
#      | status | <BranchStatus> |
#    Then the response status code should be 200
#    And the response should contain a field named "docs[0].accountHolderName" with the value "<AccountHolderName>"
#    And the response should contain a field named "docs[0].phoneNumber" with the value "<PhoneNumber>"
#    And the response should contain a field named "docs[0].businessName" with the value "<BusinessName>"
#    Examples:
#      | BranchStatus | BusinessName | AccountHolderName                     | PhoneNumber   |
#      | AUTHORIZED   | bjf          | 'ADIU COMMUNICATION SERVICE PRIVATE ' | +251911256432 |
#      | DENIED       | testm        | TAKELE GIRMA CHEKOL                   | +251911111111 |
##      | INITIATED    | false        | DELIL GEBRE WAJO                            | +251912892136 |