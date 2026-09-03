@ignore
Feature: Reusable mock-service example

  Background:
    * def users = [{ id: 1, name: 'Test User' }]

  Scenario: pathMatches('/users') && methodIs('get')
    * def response = users
    * def responseStatus = 200

  Scenario: pathMatches('/users/{id}') && methodIs('get')
    * def id = pathParams.id
    * def response = { id: '#(id)', name: 'Test User' }
    * def responseStatus = 200
