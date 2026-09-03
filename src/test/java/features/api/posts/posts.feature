@api @regression
Feature: JSONPlaceholder Posts API

  Background:
    * url apiBaseUrl
    * def defaultHeaders = call read('classpath:features/common/headers.js')
    * headers defaultHeaders

  @smoke
  Scenario: Get a post and validate its schema
    Given path 'posts', 1
    When method get
    Then status 200
    And match response ==
      """
      {
        userId: '#number',
        id: '#number',
        title: '#string',
        body: '#string'
      }
      """
    And match response.id == 1

  Scenario: List posts and validate collection contract
    Given path 'posts'
    When method get
    Then status 200
    And match response == '#[]'
    And match response == '#[100]'
    And match each response contains { userId: '#number', id: '#number', title: '#string', body: '#string' }

  Scenario: Create a post with generated test data
    * def data = call read('classpath:features/common/random-data.js')
    Given path 'posts'
    And request { title: '#(data.title)', body: 'Created by Karate', userId: 1 }
    When method post
    Then status 201
    And match response contains { title: '#(data.title)', body: 'Created by Karate', userId: 1 }
    And match response.id == '#number'

  Scenario: Update a post
    Given path 'posts', 1
    And request { id: 1, title: 'updated title', body: 'updated body', userId: 1 }
    When method put
    Then status 200
    And match response contains { id: 1, title: 'updated title', body: 'updated body', userId: 1 }

  Scenario: Delete a post
    Given path 'posts', 1
    When method delete
    Then status 200
