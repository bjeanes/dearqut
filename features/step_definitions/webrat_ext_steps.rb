When /^I dump the page$/ do
  save_and_open_page
end

Then /^the "([^\"]+)" field should exist$/ do |field|
  lambda { field_labeled(field) }.should_not raise_error
end

Then /^the "([^\"]+)" field should not exist$/ do |field|
  lambda { field_labeled(field) }.should raise_error
end