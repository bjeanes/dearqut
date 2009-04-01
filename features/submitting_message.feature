Feature: Submitting a messae
  In order to submit a message to the site
  As a user
  I want submit a message
  
  Scenario: Submitting empty message
    Given I am logged in
    And I am on the home page
    And I do not fill in "Message"
    
    When I press "Submit"

    Then I should see "Please enter a message"
   
  Scenario: Submitting a message
    Given I am logged in
    And I am on the home page

    When I fill in "Message" with "Needs more icecream"
    And I press "Submit"
    
    Then I should see "Thank you for your message"

  Scenario: Submitting a message anonymously
    Given I am not logged in
    And I am on the home page
    
    When I fill in "Message" with "Free chocolate please"
    And I press "Submit"
    
    Then I should see "Thank you for your message"
    And the message will be under the name "Anonymous"
