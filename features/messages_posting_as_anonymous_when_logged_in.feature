Feature: Messages posting as anonymous when logged in
  In order to hide my identity but still track my messages to my account
  As a user
  I want to choose to post my messages anonymously
  
  Scenario: Anonymous option should not be shown to guests
    Given I am not logged in
    When I go to the home page
    Then the "Post Anonymously" field should not exist
  
  Scenario: Anonymous option should be shown to guests
    Given I am logged in
    When I go to the home page
    Then the "Post Anonymously" field should exist
  
  Scenario: Messages posted anonymously should not have user's login
    Given I am logged in as "bjeanes"
    When I go to the home page
    And I fill in "message_body" with "Please provide more power points in all the lecture rooms!"
    And I check "Post Anonymously"
    And I press "Submit"
    Then I should not see "sincerely, bjeanes"
    But I should see "sincerely, Anonymous"
    
  
  
  