@http://www.pivotaltracker.com/story/show/1167117
Feature: View messages I have interacted with
  In order to keep track of messages I am interested in
  As an authenticated user
  I want to be able to see a list of every message I've ever commented of voted on
  
  *Acceptance:*
  * There should be a section in the account section similar to "My Messages"
  * All messages I have commented on should be shown in order of last activity
  
  Scenario: My comments
    Given a message titled "Some message"
    And a message titled "Another message"
    And a message titled "Can't touch this"
    And I am logged in as "bob"
    And I am on the home page
    When I follow "Some message"
    And I fill in "comment_body" with "I totally agree. Let's get this fixed!"
    And I check "Post Anonymously"
    And I press "Post Comment"
    Given I am on the home page
    When I follow "Another message"
    And I fill in "comment_body" with "I totally disagree. DIAF"
    And I uncheck "Post Anonymously"
    And I press "Post Comment"
    When I follow "bob"
    And I follow "My Comments"
    Then I should not see "Can't touch this"
    And I should see "Another message"
    And I should see "Some message"
  
  
  