@http://www.pivotaltracker.com/story/show/1202590 @staff
Feature: Staff members can submit 'staff response' comments to messages
  In order to respond to messages on behalf of QUT
  As a QUT staff member
  I want to be given the option to submit a staff response and have my comment identifiable with a 'staff member' badge

  *Acceptance*
  * Check box on comment form to post as staff
  * Comments added by staff when *NOT* checking the box, should not be marked as staff responses
  * If posting as staff, can NOT also check "Post anonymously"
  * Only staff can post staff messages (this needs to be a validation and the :staff attr should be protected)
  ** non-staff shouldn't even see the checkbox

  Background:
    Given a message titled "Will you go out with me"
    And an approved staff "staffer"
    
  Scenario: Verified staff can submit official responses
    Given I am on the home page
    And I am logged in as "staffer"
    When I follow "Browse"
    And I follow "Will you go out with me"
    And I fill in "comment_body" with "No. GTFO"
    And I check "Post as Staff"
    And I press "Post Comment"
    Then I should see "Comment was successfully posted"
    And I should see "(Staff)"
    
  Scenario: Verified staff can submit official responses
    Given I am on the home page
    And I am logged in as "staffer"
    When I follow "Browse"
    And I follow "Will you go out with me"
    And I fill in "comment_body" with "No. GTFO"
    And I uncheck "Post as Staff"
    And I press "Post Comment"
    Then I should see "Comment was successfully posted"
    And I should not see "(Staff)"

  Scenario: Can't check both Post as Staff and Post Anonymously
    Given I am on the home page
    And I am logged in as "staffer"
    When I follow "Browse"
    And I follow "Will you go out with me"
    And I fill in "comment_body" with "No. GTFO"
    And I check "Post as Staff"
    And I check "Post Anonymously"
    And I press "Post Comment"
    Then I should see "Staff comments cannot be anonymous"    
    
  Scenario: Normal users can't see the checkbox
    Given I am logged in
    And I am on the home page
    When I follow "Will you go out with me"
    Then I should not see "Post as Staff"
    
  Scenario: Anonymous users can't see the checkbox
    Given I am not logged in
    And I am on the home page
    When I follow "Will you go out with me"
    Then I should not see "Post as Staff"
  
  
  
    
  
  
  