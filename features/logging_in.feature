Feature: Logging in
  In order to use the site as a registered user
  As an anonymous user
  I want to log in
  
  Scenario: Successfully logging in
    Given I am not logged in
    And I have an existing account with login "fooballz"
    And I am on the home page

    When I follow "log in"
    And I fill in "Username" with "fooballz"
    And I fill in "Password" with "h4x0rk1d"
    And I press "log in"

    Then I should see "You have logged in successfully."
    And I should see "fooballz"
    And I should be logged in
    
  Scenario: Logging in with invalid details
    Given I am not logged in
    And I have an existing account with login "fooballz"
    And I am on the home page

    When I follow "log in"
    And I fill in "Username" with "fooballz"
    And I fill in "Password" with "wrongpass"
    And I press "log in"

    Then I should not see "You have logged in successfully."
    And I should see "Unable to verify your credentials"
    And I should not see "fooballz"