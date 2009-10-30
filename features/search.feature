@http://www.pivotaltracker.com/story/show/1587738
Feature: Search
  In order to find messages and comments I'm interested in
  As a user
  I want to be able to search dearQUT
  
  Scenario: Searching messages
    Given the following messages
      | body                       |
      | QUT Parking blows          |
      | Parking should be cheaper  |
      | Refec needs better food    |
      | XXXNNN sucks               |
      | Assignment minder sucks    |
      | OAS needs to stop crashing |
    And I am on the home page
    When I follow "Browse"
    And I fill in "q" with "Parking"
    And I press "Search"
    Then I should see the following
      | QUT Parking blows |
      | Parking should be cheaper |
    And I should not see the following
      | Refec needs better food    |
      | XXXNNN sucks               |
      | Assignment minder sucks    |
      | OAS needs to stop crashing |
      