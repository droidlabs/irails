Feature: Signing out
  In order to protect my data
  As a signed in user
  I want to sign out

  Scenario: Signing out
    Given I signed in as user
    When I sign out
    Then I should be signed out