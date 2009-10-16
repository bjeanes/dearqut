@http://www.pivotaltracker.com/story/show/1202580 @staff
Feature: Add 'staff option' to signon form
  In order to submit staff responses
  As a staff member of QUT
  I want to select a staff account option when I sign up

  *Acceptance:*
  * Users who select the staff option will be sent an email to a qut.edu.au address confirming their identity
  * This story doesn't cover including a link they can click to automatically approve themselves
  ** Instead just tell them to forward the email to staffaccounts@dearqut.com

  Background:
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Username" with "staff"
    And I fill in "Password" with "password"
    And I fill in "Password again" with "password"

  Scenario: Providing a QUT (non-student) address succeeds
    When I check "I am a staff member"
    And I fill in "Email" with "staff@qut.edu.au"
    And I press "Sign up"
    Then I should see "You have successfully created an account. An email has been set to your staff account to confirm you are a staff member."
    And I should be on the home page
    
  Scenario: Providing a QUT (student) address fails
    When I check "I am a staff member"
    And I fill in "Email" with "staff@student.qut.edu.au"
    And I press "Sign up"
    Then I should see "You must provide a staff email address to register a staff account."
    And I should not be on the home page
    
  Scenario: Providing a QUT address without checking box creates normal account
    And I fill in "Email" with "staff@qut.edu.au"
    And I press "Sign up"
    Then I should see "You have successfully created an account."
    And I should be on the home page