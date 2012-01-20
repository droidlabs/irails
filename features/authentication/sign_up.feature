Feature: Sign up
  In order to log into the system
  As a user
  I want to register a new account with the system

  Scenario: User signs up
    When I submit registration form
    Then I should be on the home page
    And I should receive registration confirmation email
    When I follow "Confirm my account" in the email
    Then I should be signed in
    And I should be on the home page

  Scenario: User resents email confirmation instructions
    Given a not confirmed user exists with email: "chuck@example.com", password: "123456"
    And I go to the resend confirmation instructions page
    When I fill in "Email" with "new_user@example.com"
    And press "Resend confirmation instructions"
    Then 1 email should be delivered with subject: "Confirmation instructions"

  Scenario: User signs up with invalid data
    When I submit registration form with invalid data
    Then I should see "can't be blank" error for "user_full_name"
    And I should see "invalid" error for "user_email"