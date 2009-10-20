Given /^I am not logged in$/ do
  reset!
end

Then /^I should be logged in$/ do
  should_be_logged_in
end

Then /^I should be logged(?: in as "([^"]+)")?$/ do |login|
  should_be_logged_in
  And(%Q{I should see "#{login || current_user.login}"})
end

Then /^I should be redirected to (.+)$/ do |path|
  path = path_to(path) unless path[0] == '/'
  response.should redirect_to(path)
end

Given /^I have an existing account(?: with login "([^"]+)")?$/ do |login|
  login.nil? ? create_user : create_user(login)
end

Given /^I am logged in(?: as "([^\"]+)")?$/ do |user|
  user = user ? create_user(user) : create_user
  post_via_redirect '/user_sessions', :login => user.login, :password => user.password
end

Given /^I do not fill in "([^\"]*)"$/ do |field|
  fill_in field, :with => ''
end

Given /^I am logged in as an admin user$/ do
  user = create_user('admin', 'password', true)
  post_via_redirect '/user_sessions', :login => user.login, :password => user.password
end
