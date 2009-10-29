@http://www.pivotaltracker.com/story/show/1388130 @moderation
Feature: Admin - Spam moderation
  In order to minimise spam and increase message relevance
  As an administrator
  I want to view all messages that are 'spam' or 'moderate' status, and choose whether to delete them, or mark them as not spam

  *Acceptance*:
  * Should be an admin section with a list of all messages and comments that need moderation
  * Should be ordered by status (moderate first, spam second), then by posted date (oldest first)
  * When a message is confirmed as spam, it should be removed from the list (but not the database, as existing spam messages are used to detect future spam messages as well as provide metrics on our level of success with catching them)

  Background:
    Given the following messages
      | body                                                   | moderation_status  | user |
      | plz can buy some viagra at http://awesome.ru. rolex!   | moderation   |      |
      | please make the carpark more affordable                | ham          |      |
      | cool website!                                          | spam         |      |
      | interesting point. rolexes are better than viagra      | spam         |      |
    And I am logged in as an admin user
    And I am on the admin dashboard page
    
  Scenario: The admin dashboard shows how many messages are currently spam
    Then I should see "2 spam, 1 need moderation"
    When I follow "2 spam, 1 need moderation"
    Then I should be on the admin message moderation index page
    
  Scenario: There is an admin spam moderation page and it is linked to in the navigation
    When I follow "Moderation"
    And I follow "Messages"
    Then I should be on the admin message moderation index page
    
  Scenario: The admin spam moderation page lists all messages
    When I follow "Moderation"
    And I follow "Messages"
    Then I should see the following in table "#spam-messages"
      | Author    | Body                                                   | Status   |
      | Anonymous | plz can buy some viagra at http://awesome.ru. rolex!   | moderate |
      | Anonymous | cool website!                                          | spam     |
      | Anonymous | interesting point. rolexes are better than viagra      | spam     |

  Scenario: Marking message as spam removes it from the site and from the moderation queue
    When I follow "Moderation"
    And I follow "Messages"
    And I follow "plz can buy some viagra at http://awesome.ru. rolex!"
    And I press "This Is Spam"
    Then I should be on the admin message moderation index page
    And I should see "You have successfully marked that message as spam."
    Then I should see the following in table "#spam-messages"
      | Author    | Body                                              | Status |
      | Anonymous | cool website!                                     | spam   |
      | Anonymous | interesting point. rolexes are better than viagra | spam   |
    When I go to the home page
    Then I should not see "plz can buy some viagra"
    But I should see "please make the carpark more affordable"

  Scenario: Marking message as ham adds it back to site but removes it from the moderation queue
    When I follow "Moderation"
    And I follow "Messages"
    And I follow "plz can buy some viagra at http://awesome.ru. rolex!"
    And I press "This Is Ham"
    Then I should be on the admin message moderation index page
    And I should see "You have successfully marked that message as ham."
    Then I should see the following in table "#spam-messages"
      | Author    | Body                                              | Status |
      | Anonymous | cool website!                                     | spam   |
      | Anonymous | interesting point. rolexes are better than viagra | spam   |
    When I go to the home page
    Then I should see "plz can buy some viagra"
    And I should see "please make the carpark more affordable"
  
