@http://www.pivotaltracker.com/story/show/1167099
Feature: Browse messages that are most controversial
  In order to view controversial messages
  As any user
  I want to see all the messages with high amounts of disagrees relative to agrees at the top of the list

  Scenario: The most controversial messages should be at the top
    Given a message titled "Very controversial" with 100 agrees and 102 disagrees
    And a message titled "Slightly controversial" with 13 agrees and 10 disagrees
    And a message titled "Hardly controversial" with 13 agrees and 3 disagrees
    And a message titled "Mostly disagreeing" with 3 agrees and 13 disagrees
    And I am not logged in
    When I go to the home page
    And I follow "Browse"
    And I follow "Controversial" within "#filter"
    Then I should see "Very controversial" before "Slightly controversial"
    And I should see "Slightly controversial" before "Hardly controversial"
    And I should see "Hardly controversial" before "Mostly disagreeing"
  
  