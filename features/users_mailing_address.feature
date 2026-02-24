Feature: Get user JSON (JSON:API)
  Background:
    And the "users" memory store is cleared

  Scenario: User exists (shipping address present)
    Given I create a "users" resource via the API with:
      | name                           | Ada Lovelace      |
      | email                          | ada@example.com   |
      | shipping_address_line_1        | 10 Downing Street |
      | shipping_address_line_2        | Flat B            |
      | shipping_address_postal_code   | SW1A 2AA          |
      | shipping_address_town          | London            |
      | shipping_address_county        | Greater London    |
      | shipping_address_country       | GB                |
      | business_address_line_1        | 1 The Avenue      |
      | business_address_line_2        | Suite 200         |
      | business_address_postal_code   | EC1A 1BB          |
      | business_address_town          | London            |
      | business_address_county        | Greater London    |
      | business_address_country       | GB                |
    When I request the user JSON:API document for the created user
    Then the response status should be 200
    And the response should be a valid JSON:API resource document for type "users"
    And the JSON:API document should include user attributes:
      | name                        | Ada Lovelace      |
      | email                       | ada@example.com   |
      | shipping_address_line_1     | 10 Downing Street |
      | shipping_address_postal_code| SW1A 2AA          |

  Scenario: User does not exist (404)
    When I request the user JSON:API document for user id "999999999"
    Then the response status should be 404
    And the response should be a valid JSON:API error document
    And the JSON:API error should have status "404"
