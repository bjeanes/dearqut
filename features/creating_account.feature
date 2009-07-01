Feature: Creating an account
  In order to use the site as a registered user
  As an anonymous user
  I want to create myself an account
  
  Scenario: Creating
    Given I am not logged in
    And I am on the homepage

    When I follow "sign up"
    And I fill in "Username" with "buttonesque"
    And I fill in "Password" with "1337h4x0r"
    And I fill in "Password again" with "1337h4x0r"
    And I press "Sign Up"
  
    And I should see "buttonesque"
    And I should be logged in
