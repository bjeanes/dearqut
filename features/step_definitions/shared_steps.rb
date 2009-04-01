Given /^I am not logged in$/ do
  # pending 
end

Then /^I should be logged in$/ do
  
end

Then /^I should be redirected to (.+)$/ do |path|
  path = path_to(path) unless path[0] == '/'

  response.should redirect_to(path)
end

Given /^I have an existing account$/ do
  pending
end

Given /^I am logged in$/ do
  pending
end

Given /^I do not fill in "([^\"]*)"$/ do |arg1|
  pending
end

Then /^the message will be under the name "([^\"]*)"$/ do |arg1|
  pending
end
