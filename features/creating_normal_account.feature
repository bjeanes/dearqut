@http://www.pivotaltracker.com/story/show/1166751 @accounts
Feature: Creating normal account
  In order to access dearQUT service
  As a user
  I want to create a normal user account for creating messages

  Scenario: Creating an account
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Username" with "student"
    # And I fill in "Email" with "student@student.com"
    And I fill in "Password" with "password"
    And I fill in "Password again" with "password"
    And I press "Sign up"
    Then I should see "You have successfully created an account"
    And I should be on the home page
    
  Scenario: Creating an account with invalid details
    Given there is the following user
      | login   | password |
      | student | password |
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Username" with "student"
    # And I fill in "Email" with "student@student.com"
    And I fill in "Password" with "password"
    And I fill in "Password again" with "pass"
    And I press "Sign up"
    Then I should see "There was an error creating your account"
    And I should see "Sign up"


  
  
  