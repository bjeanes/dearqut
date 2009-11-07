@http://www.pivotaltracker.com/story/show/1167015 @tagging
Feature: Tag suggestion
  As a guest or user
  When I submit a message
  It should suggest tags I should use

  Scenario: Tag suggestion
    Given I am not logged in
    And I am on the home page
    When I fill in "message_body" with "The parking at QUT Gardens Point sucks. It takes way too long to get a park."
    And I press "SUBMIT"
    Then I should see the following suggested tags:
     | park    |
     | parking |
     | way     |
  
  
  
