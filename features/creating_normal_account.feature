@http://www.pivotaltracker.com/story/show/1166751 @accounts
Feature: Creating normal account
  In order to access dearQUT service
  As a user
  I want to create a normal user account for creating messages

  Scenario: Creating an account
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Login" with "student"
    And I fill in "Email" with "student@student.com"
    And I fill in "Password" with "password"
    And I fill in "Password Confirmation" with "password"
    And I press "Sign up"
    Then I should see "Your account has been created successfully!"
    And I should be on the home page
    
  Scenario: Creating an account with invalid details
    Given a user named "student"
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Login" with "student"
    And I fill in "Email" with "student@student.com"
    And I fill in "Password" with "password"
    And I fill in "Password Confirmation" with "pass"
    And I press "Sign up"
    Then I should see "Login has been taken"
    Then I should see "Email has been taken"
    Then I should see "Password does not match confirmation"
    And I should be on the sign up page


  
  
  