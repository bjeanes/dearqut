Given /^there is the following user$/ do |table|
  table.hashes.each do |user_details|
    user                       = User.make_unsaved(user_details)
    user.password_confirmation = user_details["password"]
    user.admin                 = user_details["admin"] == "true" ? true : false
    user.save!
  end
end

Given /^I sign up as a QUT staff member with login "([^\"]*)"$/ do |login|
  When %Q{I go to the sign up page}
  And  %Q{I fill in "Username" with "#{login}"}
  And  %Q{I fill in "Password" with "password"}
  And  %Q{I fill in "Password again" with "password"}
  And  %Q{I fill in "Email" with "#{login}@qut.edu.au"}
  And  %Q{I check "I am a QUT staff member"}
  And  %Q{I press "Sign Up"}
end

Then /^I should( not)? be a staff member$/ do |n|
  Then %Q{I should#{n} see image "Verified Staff Member"}
end

Given /^an approved staff "([^\"]*)"$/ do |name|
  Cucumber %Q{
    Given I sign up as a QUT staff member with login "staffer"
    And I am logged out
    And I am logged in as an admin user
    And I go to the admin page
    When I follow "1 pending staff account"
    And I follow "staffer"
    And I press "Approve"
    And I go to the admin page
    Given I am logged out
    And I am logged in as "staffer"
    Then I should be a staff member
  }
end
