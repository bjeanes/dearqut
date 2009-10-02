Feature: Admin logging in
  In order to use the administration panel
  As an admin
  I want to login
  
  Scenario: I should be shown the login page
    Given I am not logged in
    When I go to the admin page
    Then I should see "Login"
    And I should see "Username"
    And I should see "Password"
    
  Scenario: I should see the admin page when I log in with administrator account
    Given I am not logged in
    And there is the following user
     | login | password | admin |
     | admin | secret   | true  |
    When I go to the admin page
    And I fill in "Username" with "admin"  
    And I fill in "Password" with "secret"
    And I press "Login"
    Then I should be on the admin page