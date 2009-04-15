Given /^I am not logged in$/ do
  @current_user = nil
  reset!
end

Then /^I should be logged in$/ do
  @current_user.should_not be_nil
  And(%Q{I should see "#{@current_user.login}"})
end

Then /^I should be redirected to (.+)$/ do |path|
  path = path_to(path) unless path[0] == '/'

  response.should redirect_to(path)
end

Given /^I have an existing account$/ do
  
end

Given /^I am logged in(?: as (.+))?$/ do |user|
  @current_user ||= user ? create_user(user) : create_user
  post_via_redirect '/session', :login => @current_user.login, :password => @current_user.password
end

Given /^I do not fill in "([^\"]*)"$/ do |field|
  fill_in field, ''
end

Then /^the message will be under the name "([^\"]*)"$/ do |author|
  pending
end

def create_user(user = "leet", password = "h4x0r")
  User.find_by_login(user) || User.create(:login => user, :password => password)
end