@http://www.pivotaltracker.com/story/show/1167117
Feature: View messages I have interacted with
  In order to keep track of messages I am interested in
  As an authenticated user
  I want to be able to see a list of every message I've ever commented of voted on

  *Acceptance*:
  * Ordered by most recent activity (by anyone, not just me)

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
    When I follow "Agree"
    And I follow "charlie"
    And I follow "My Activity"
    Then I should see "this is a super duper message. hai"