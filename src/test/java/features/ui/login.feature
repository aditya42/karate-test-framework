@ui @ignore
Feature: Optional browser UI example

  Background:
    * configure driver = { type: 'chrome', headless: true }

  Scenario: Login to SauceDemo
    Given driver uiBaseUrl
    And input('#user-name', 'standard_user')
    And input('#password', 'secret_sauce')
    When click('#login-button')
    Then waitForUrl('**/inventory.html')
    And match driver.title == 'Swag Labs'
