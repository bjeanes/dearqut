Given /^I am not logged in$/ do
  # pending 
end

Then /^I should be logged in$/ do
  
end

Then /^I should be redirected to (.+)$/ do |path|
  path = path_to(path) unless path[0] == '/'

  response.should redirect_to(path)
end
