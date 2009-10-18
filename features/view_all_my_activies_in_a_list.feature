@http://www.pivotaltracker.com/story/show/1509583
Feature: Activity log
  In order to see a history of everything I have done on the site
  As a user
  I want to see an log of my activities

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

  Scenario: Viewing messages I am commented on
    When I press "Agree"
    And I follow "charlie"
    And I follow "My Activity"
    Then I should see "this is a super duper message. hai"