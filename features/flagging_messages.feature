@http://www.pivotaltracker.com/story/show/1167157 @http://www.pivotaltracker.com/story/show/1202762 @moderation
Feature: Flagging messages (for moderation)
  In order to minimise useless messages (spam, inappropriate, confusing, etc)
  As an authenticated user
  I want to be able to flag a message for moderation

  *Acceptance*:
  * Flag link on each message
  * clicking link should bring down a small text box
  * textbox must be filled in with a flag_reason for flagging
  * when flag flag_reason is submitted, the message should be hidden
  * flagged messages should be put into a new section that only admins can see and then be permanently removed or permanently approved as an OK message

  Scenario: Flagging a message causes it to appear in moderation queue
    Given a message titled "Dirty message"
    And a message titled "Good message"
    And a message titled "Pointless message"
    And I am not logged in
    And I am on the home page
    When I follow "Dirty message"
    And I follow "Flag for moderation"
    Then I fill in "flag_reason" with "Inappropriate"
    When I press "Submit"
    Then I should see "Message has been flagged for moderation"
    When I am on the home page
    Then I should not see "Dirty message"
    Given I am logged in as an admin user
    And I am on the admin page
    When I follow "Moderation"
    When I follow "Messages"
    Then I should see "Dirty message"
    When I follow "Dirty Message"
    Then I should see "Inappropriate"
    When I press "Cull it"
    Then I should see "You have successfully marked that message as cull"
    When I am on the home page
    Then I should not see "Dirty message"