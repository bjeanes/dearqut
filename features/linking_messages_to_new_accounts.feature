@http://www.pivotaltracker.com/story/show/1166851 @accounts
Feature: Associating guest messages with new accounts
  In order to track my posted dearQUT messages
  As an anonymous user
  I want to create messages, then login or create an account and have my messages associated with my logged in account

  *Acceptance*:
  * If I then create an account (either via Twitter or normally), it should associate this message with my new account
  * If I login after posting the message, I should be given the option to associate my anonymously-created messages with the account I just logged into

  Scenario: Messages created by guest and then the guest registers, messages posted pre-signup belong to user
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
    And show me the page
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
    
  