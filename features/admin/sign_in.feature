Feature: Sign in
  In order to identify myself as admin user
  As a registered admin user
  I want to sign in to admin dashboard

  Scenario: Admin user signs in
    Given a admin user exists with email: "me@example.com", password: "123456"
    When I go to the admin sign in page
    And fill in "Email" with "me@example.com"
    And fill in "Password" with "123456"
    And press "Login"
    And I should see "Signed in successfully."

  Scenario: Admin user signs in with invalid credentials
    When I go to the admin sign in page
    And fill in "Email" with "invalid email"
    And fill in "Password" with "invalid password"
    And press "Login"
    Then I should see "Invalid email or password."