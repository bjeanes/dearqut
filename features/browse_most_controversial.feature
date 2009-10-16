@http://www.pivotaltracker.com/story/show/1167099
Feature: Browse messages that are most controversial
  In order to view controversial messages
  As any user
  I want to see all the messages with high amounts of disagrees relative to agrees at the top of the list

  Scenario: The most controversial messages should be at the top
    Given a message titled "Very controversial" with 10 agrees and 10 disagrees
    And a message titled "Slightly controversial" with 13 agrees and 10 disagrees
    And a message titled "Hardly controversial" with 13 agrees and 3 disagrees
    And I am not logged in
    When I go to the home page
    And I follow "Most Controversial"
    Then I should see /Very controversial.*Slightly controversial.*Hardly controversial/
  
  
  