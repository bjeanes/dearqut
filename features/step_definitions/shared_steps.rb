Given /^I am not logged in$/ do
  reset!
end

Then /^I should be logged in$/ do
  current_user.should_not be_nil
  And(%Q{I should see "#{current_user.login}"})
end

Then /^I should be logged in as "([^"]+)"$/ do |login|
  And(%Q{I should see "#{login}"})
end

Then /^I should be redirected to (.+)$/ do |path|
  path = path_to(path) unless path[0] == '/'
  response.should redirect_to(path)
end

Given /^I have an existing account(?: with login "([^"]+)")?$/ do |login|
  login.nil? ? create_user : create_user(login)
end

Given /^I am logged in(?: as (.+))?$/ do |user|
  user = user ? create_user(user) : create_user
  post_via_redirect '/session', :login => user.login, :password => user.password
end

Given /^I do not fill in "([^\"]*)"$/ do |field|
  fill_in field, :with => ''
end

Then /^the message will be under the name "([^\"]*)"$/ do |author|
  pending
end