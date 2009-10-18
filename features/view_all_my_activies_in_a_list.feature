@http://www.pivotaltracker.com/story/show/1167117
Feature: View messages I have interacted with
  In order to keep track of messages I am interested in
  As an authenticated user
  I want to be able to see a list of every message I've ever commented of voted on

  *Acceptance*:
  * Ordered by most recent 
  * If I comment, a new entry should appear at the top of the list
  * If I vote, a new entry should appear at the top of the list
  * If I post a message, a new entry should appear at the top of the list

  Background: 
    Given the following message
      | body                               |
      | this is a super duper message. hai |
    And I am logged in as "charlie"
    When I follow "Browse"
    And I follow "this is a super duper message. hai"

  Scenario: Viewing messages I am commented on
    When I fill in "comment_body" with "This is my comment"
    And I press "Post Comment"
    And I follow "charlie"
    And I follow "My Activity"
    Then I should see "this is a super duper message. hai"

  @wip
  Scenario: Viewing messages I am commented on
    When I press "Agree"
    And I follow "charlie"
    And I follow "My Activity"
    Then I should see "this is a super duper message. hai"