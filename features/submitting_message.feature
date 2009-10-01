Feature: Submitting a message
  In order to submit a message to the site
  As a user
  I want submit a message
  
  Scenario: Submitting empty message
    Given I am logged in
    And I am on the home page
    And I do not fill in "message_body"
    When I press "SUBMIT"
    Then I should see "Please enter a message"
   
  Scenario: Submitting a message
    Given I am logged in
    And I am on the home page
    When I fill in "message_body" with "Needs more ice cream"
    And I press "SUBMIT"
    Then I should see "Thank you for your message"

  Scenario: Submitting a message as a guest
    Given I am not logged in
    And I am on the home page
    When I fill in "message_body" with "Free chocolate please"
    And I press "SUBMIT"
    Then I should see "Thank you for your message"
    And the message will be under the name "Anonymous"
