Feature: Sign in
  In order to identify myself in the system
  As a registered user
  I want to sign in

  Scenario: User signs in
    Given I exist as a user
    When I sign in with valid credentials
    Then I should be signed in

  Scenario: User signs in with invalid credentials
    Given I exist as a user
    When I sign in with invalid credentials
    Then I should be signed out