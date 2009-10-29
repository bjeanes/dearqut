@http://www.pivotaltracker.com/story/show/1202597 @staff
Feature: Validate staff accounts via email
  In order to confirm my identity
  As a staff member
  I want to receive an email with a validation link and have my account validated when I click the link

  *Acceptance:*
  * email must be qut.edu.au
  * they will get a pending staff status
  * pending staff members will appear in the administration panel
  * admins can then check in QUT directory that they are staff and mark them as staff
  * QUT staff members that have been APPROVED will see [something different in interface - ask Ri]
  
  Background:
    Given I sign up as a QUT staff member with login "staffer"
    Then I should not be a staff member

    Given I am logged out
    And I am logged in as an admin user
    And I go to the admin page
    Then I should see "1 pending staff account"
    Then I should see "0 verified staff accounts"
    When I follow "1 pending staff account"
    And I follow "staffer"
  
  Scenario: Approving a QUT staff member
    And I press "Approve"
    And I go to the admin page
    Then I should see "0 pending staff accounts"
    Then I should see "1 verified staff account"
    
    Given I am logged out
    And I am logged in as "staffer"
    Then I should be a staff member

  Scenario: Denying a QUT staff member
    And I press "Deny"
    And I go to the admin page
    Then I should see "0 pending staff accounts"
    Then I should see "0 verified staff accounts"
    
    Given I am logged out
    And I am logged in as "staffer"
    Then I should not be a staff member
  
