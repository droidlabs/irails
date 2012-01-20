Feature: Sign in
  In order to identify myself in the system
  As a registered user
  I want to sign in

  Scenario: User signs in
    Given I exist as a confirmed user
    When I sign in with valid credentials
    Then I should be signed in
    And I should be on the home page
    And I should see "Signed in successfully."

  Scenario: User signs in with invalid credentials
    Given I exist as a confirmed user
    When I sign in with invalid credentials
    Then I should be signed out
    And I should see "Invalid email or password."

  Scenario: User has not confirmed email address
    Given I exist as a not confirmed user
    When I sign in with valid credentials
    Then I should be signed out
    And I should see "You have to confirm your account before continuing."

  Scenario: User forgets his password
    Given I exist as a not confirmed user
    When I request new password
    Then I should receive reset password instructions email