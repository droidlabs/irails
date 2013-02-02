Feature: Attacking a monster
  Background:
    Given I signed in as user

  Scenario: Logging out
    When I click to "logot"
    Then I should be logged out