@http://www.pivotaltracker.com/story/show/1201472
Feature: Provide ability to change vote
  In order to correct my vote if I make a mistake or change my mind
  As a user
  I want the ability to change my vote
  
  *Acceptance*:
  * Agreeing then disagreeing is counted as a disagree vote
  * Disagreeing then agreeing is counted as an agree vote
  * Agreeing then pressing agree again does not count as two agrees
  
  Background:
    Given the following message
      | body                               |
      | this is a super duper message. hai |
    And I am logged in as "charlie"
    When I follow "Browse"
    And I follow "this is a super duper message. hai"

  Scenario: Agreeing then disagreeing is counted as a disagree vote
    When I press "Agree"
    Then I should see "You agreed"
    And I should not see "You disagreed"
    When I press "Disagree"
    Then I should see "You disagreed"
    And I should not see "You agreed"
    And I should see "0" within "button.agree span.num"
    And I should see "1" within "button.disagree span.num"

  Scenario: Disagreeing then agreeing is counted as an agree vote
    When I press "Disagree"
    Then I should see "You disagreed"
    And I should not see "You agreed"
    When I press "Agree"
    Then I should see "You agreed"
    And I should not see "You disagreed"
    And I should see "1" within "button.agree span.num"
    And I should see "0" within "button.disagree span.num"
    
  Scenario: Agreeing then pressing agree again does not count as two agrees
    When I press "Agree"
    Then I should see "You agreed"
    And I should not see "You disagreed"    
    When I press "Agree"
    Then I should see "You agreed"
    And I should not see "You disagreed"
    And I should see "1" within "button.agree span.num"
    And I should see "0" within "button.disagree span.num"