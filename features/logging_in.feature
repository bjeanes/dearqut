Feature: Logging in
  In order to use the site as a registered user
  As an anonymous user
  I want to log in
  
  Scenario: Successfully logging in
    Given I am not logged in
    And I have an existing account

    When I follow "log in"
    And I fill in "Username" with "buttons"
    And I fill in "Password" with "1337h4x0r"
    And I press "log in"

    Then I should be redirected to the home page
    And I should see "buttons"
    And I should be logged in