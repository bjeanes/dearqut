@http://www.pivotaltracker.com/story/show/1457035 @wip
Feature: Signed in users can choose to comment on a message anonymously
  In order to protect my anonymity
  As an authenticated user
  I want to choose for my message to display as "Anonymous"

  Acceptance:
  * When posting comment, there should be a checkbox that says "post anonymously"
  * Comments should still be tied to account so author can keep track of them

  Background:
    Given the following message
      | body                                               | user |
      | Please make the QUT Garden's Point parking cheaper |      |

  Scenario: Anonymous option should not be shown to guests
    Given I am not logged in
    When I go to the messages page
    And I follow "Please make the QUT Garden's Point parking cheaper"
    Then the "Post Anonymously" field should not exist
  
  Scenario: Anonymous option should be shown to guests
    Given I am logged in
    When I go to the messages page
    And I follow "Please make the QUT Garden's Point parking cheaper"
    Then the "Post Anonymously" field should exist
  
  Scenario: Messages posted anonymously should not have user's login
    Given I am logged in as "bjeanes"
    When I go to the messages page
    And I follow "Please make the QUT Garden's Point parking cheaper"
    And I fill in "comment_body" with "I totally agree. Let's get this fixed!"
    And I check "Post Anonymously"
    And I press "Post Comment"
    Then I should not see /Posted by:\s+bjeanes/
    But I should see /Posted by:\s+Anonymous/