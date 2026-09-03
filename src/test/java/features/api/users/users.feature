@api @regression
Feature: JSONPlaceholder Users API - data driven

  Background:
    * url apiBaseUrl
    * headers call read('classpath:features/common/headers.js')

  @smoke
  Scenario Outline: Get user <id> from CSV and validate expected identity
    * def userId = parseInt(id)

    Given path 'users', userId
    When method get
    Then status 200

    And match response.id == userId
    And match response.name == expectedName
    And match response.email == '#string'
    And match response.address == '#object'

    Examples:
      | read('classpath:test-data/users.csv') |