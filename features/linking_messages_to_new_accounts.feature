@http://www.pivotaltracker.com/story/show/1166851 @accounts
Feature: Associating guest messages with new accounts
  In order to track my posted dearQUT messages
  As an anonymous user
  I want to create messages, then login or create an account and have my messages associated with my logged in account

  *Acceptance*:
  * If I then create an account (either via Twitter or normally), it should associate this message with my new account
  * If I login after posting the message, I should be given the option to associate my anonymously-created messages with the account I just logged into

  Background:
    Given I am not logged in
    And I am on the home page
    When I fill in "message_body" with "Hello world"
    And I press "SUBMIT"
    Given I am on the home page
    When I fill in "message_body" with "Your face"
    And I press "SUBMIT"
    Given I am on the home page
    When I fill in "message_body" with "Hurr durr"
    And I press "SUBMIT"

  Scenario: Messages created by guest and then the guest registers, messages posted pre-signup belong to user
    When I follow "Sign Up"
    And I fill in "Username" with "student"
    And I fill in "Password" with "password"
    And I fill in "Password again" with "password"
    And I press "Sign up"

    Then I should see "You have successfully created an account"
    And I should see "We have found a few messages that may belong to you"
    And I should see the following
      | Hello world |
      | Your face   |
      | Hurr durr   |
    Then I choose "Mine" within "table tr:nth-child(1)"
    Then I choose "Mine but keep anonymous" within "table tr:nth-child(2)"
    Then I choose "Not mine" within "table tr:nth-child(3)"
    And I press "Submit"
    Then I should see "Messages processed successfully"
    When I follow "student"
    And I follow "Created Messages"
    Then I should see "Hello world"
    Given I am not logged in
    And I am on the home page
    When I follow "Hello world"
    Then I should not see "student"
    
    When I follow "student"
    And I follow "Created Messages"
    Then I should see "Hello world"
    Then I should see "Your face"
    But I should not see "Hurr durr"
    
    Given I am not logged in
    And I am on the home page
    When I follow "Hello world"
    Then  I should not see "Anonymous"
    But I should see "student"
    Given I am on the home page
    When I follow "Your face"
    Then I should not see "student"
    But I should see "Anonymous"
    
  Scenario: Messages created by guest and then the guest log in, messages posted pre-log in belong to user
    Given I have an existing account with login "student"
    When I go to login page
    And I fill in "Username" with "student"
    And I fill in "Password" with "password"
    And I press "Log In"
    
    Then I should see "We have found a few messages that may belong to you"
    And I should see the following
      | Hello world |
      | Your face   |
      | Hurr durr   |
    Then I choose "Mine" within "table tr:nth-child(1)"
    Then I choose "Mine but keep anonymous" within "table tr:nth-child(2)"
    Then I choose "Not mine" within "table tr:nth-child(3)"
    And I press "Submit"
    Then I should see "Messages processed successfully"
    
    When I follow "student"
    And I follow "Created Messages"
    Then I should see "Hello world"
    Then I should see "Your face"
    But I should not see "Hurr durr"
    
    Given I am not logged in
    And I am on the home page
    When I follow "Hello world"
    Then  I should not see "Anonymous"
    But I should see "student"
    Given I am on the home page
    When I follow "Your face"
    Then I should not see "student"
    But I should see "Anonymous"
  