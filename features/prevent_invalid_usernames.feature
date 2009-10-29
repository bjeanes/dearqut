@http://www.pivotaltracker.com/story/show/1589216 @accounts @wip
Feature: Prevent invalid usernames
  *Acceptance*:
  * Unable to sign up with usernames like "Blah (Staff)" etc


  Background:
    Given I am not logged in
    And I am on the home page
    And I follow "Sign up"
    
  Scenario: Prevent all symbols except
    Given context
    When event
    Then outcome
  
  
  
