@http://www.pivotaltracker.com/story/show/1167157 @moderation @wip
Feature: Flagging messages (for moderation)
  In order to minimise useless messages (spam, inappropriate, confusing, etc)
  As an authenticated user
  I want to be able to flag a message for moderation

  *Acceptance*:
  * Flag link on each message
  * clicking link should bring down a small text box
  * textbox must be filled in with a reason for flagging
  * when flag reason is submitted, the message should be hidden
  * flagged messages should be put into a new section that only admins can see and then be permanently removed or permanently approved as an OK message

  Scenario: Flagging a message causes it to appear in moderation queue
    Given a message titled "Dirty message"
    And a message titled "Good message"
    And a message titled "Pointless message"
    And I am not logged in
    And I am on the home page
    When I follow "Dirty message"
    And I follow "Flag message for moderation"
    Then I should see "Message has been flagged for moderation"
    When I am on the home page
    Then I should see "Dirty message"
    Given I am logged in as admin
    And I am on the admin page
    When I follow "Flagged Messages"
    Then I should see "Dirty message"
    
  @wip
  Scenario: Each session/user can only flag a message once
    Given a message titled "Dirty message"
    And a message titled "Good message"
    And a message titled "Pointless message"
    And I am not logged in
    And I am on the home page
    When I follow "Dirty message"
    And I follow "Flag message for moderation"
    Then I should see "Message has been flagged for moderation"
    And I should see "Dirty message"
    When I should not see "Flag message for moderation"
    Given I am logged in as admin
    And I am on the admin page
    When I follow "Flagged Messages"
    Then I should see "Dirty message"
    
  @wip
  Scenario: Flagging a message 3 times causes it to be hidden from the site
    Given a message titled "Dirty message"
    And a message titled "Good message"
    And a message titled "Pointless message"
    And I am not logged in
    And I am on the home page
    When I follow "Dirty message"
    And I follow "Flag message for moderation"
    Then I should see "Message has been flagged for moderation"
    When I am on the home page
    Then I should see "Dirty message"
    Given I am logged in as admin
    And I am on the admin page
    When I follow "Flagged Messages"
    Then I should see "Dirty message"

