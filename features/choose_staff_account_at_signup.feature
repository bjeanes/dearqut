@http://www.pivotaltracker.com/story/show/1202580 @staff
Feature: Add 'staff option' to signon form
  In order to submit staff responses
  As a staff member of QUT
  I want to select a staff account option when I sign up

  *Acceptance:*
  * Users who select the staff option must provide a qut staff email address (not student!!)
  * They can provide any email address if they don't choose to be a staff member
  * A message is shown describing to the user that their staff status is pending approval
  ** We will need to approve who are staff members manually (for now)
  ** Another story exists in Pivotal Tracker for sending them out an email.

  Background:
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Username" with "staff"
    And I fill in "Password" with "password"
    And I fill in "Password again" with "password"

  Scenario: Providing a QUT (non-student) address succeeds
    When I check "I am a QUT staff member"
    And I fill in "Email" with "staff@qut.edu.au"
    And I press "Sign up"
    Then I should see "You have successfully created an account. Your staff account will be activated after an admin confirms that you are a staff member."
    And I should be on the home page
    
  Scenario: Providing a QUT (student) address fails
    When I check "I am a QUT staff member"
    And I fill in "Email" with "staff@student.qut.edu.au"
    And I press "Sign up"
    Then I should see "You must provide a staff email address to register a staff account."
    And I should not be on the home page
    
  Scenario: Providing a QUT address without checking box creates normal account
    And I fill in "Email" with "staff@qut.edu.au"
    And I press "Sign up"
    Then I should see "You have successfully created an account."
    And I should be on the home page