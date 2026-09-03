@graphql @ignore
Feature: Optional GraphQL example

  Scenario: Query a country by code
    Given url 'https://countries.trevorblades.com/'
    And request
      """
      {
        query: 'query($code: ID!) { country(code: $code) { code name capital currency } }',
        variables: { code: 'US' }
      }
      """
    When method post
    Then status 200
    And match response.data.country.code == 'US'
    And match response.data.country.name == '#string'
