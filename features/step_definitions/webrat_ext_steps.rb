When /^I dump the page$/ do
  save_and_open_page
end

Then /^the "([^\"]+)" field should exist$/ do |field|
  lambda { field_labeled(field) }.should_not raise_error
end

Then /^the "([^\"]+)" field should not exist$/ do |field|
  lambda { field_labeled(field) }.should raise_error
end

Then /^I should see the following in table "([^"]+)"$/ do |selector, expected_table|
  actual_table = element_at("table#{selector}").to_table
  view = ActionView::Base.new
  actual_table.map { |row| row.map { |column| column.gsub!(/<.*?>|^\s+|\s+$/, '').to_s } }
  actual_table.should == expected_table.raw
end