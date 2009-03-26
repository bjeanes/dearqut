Feature: Creating an account
  In order to use the site as a registered user
  As an anonymous user
  I want to create myself an account
  
  Scenario: Creating
    Given I am not logged in
    And I am on the homepage

    When I follow "sign up"
    And I fill in "Username" with "buttons"
    And I fill in "Password" with "1337h4x0r"
    And I fill in "Password Confirmation" with "1337h4x0r"
    And I press "Submit"
  
    Then I should be redirected to the home page
    And I should see "buttons"
    And I should be logged in
