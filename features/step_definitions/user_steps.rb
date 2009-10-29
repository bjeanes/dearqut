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
  Then %Q{I should#{n} see "Verified Staff Member"}
end
