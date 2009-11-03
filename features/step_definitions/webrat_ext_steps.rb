Then /^I should not be on (.+)$/ do |page_name|
  URI.parse(current_url).path.should_not == path_to(page_name)
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

Then /^I should see "([^\"]*)" before "([^\"]*)"$/ do |first, second|
  response.body.should contain(Regexp.new("#{first}.*#{second}", Regexp::MULTILINE))
end

Then /^I should( not)? see image "([^\"]*)"$/ do |n, alt_text|
  begin
    element_at("img[alt='#{alt_text}']")
  rescue Webrat::NotFoundError
    flunk unless n
  end
end


Then /^I should( not)? see the following$/ do |n, table|
  table.rows.each do |line|
    Then %Q{I should#{n} see #{line[0].inspect}}
  end
end

Then /^(?!I should see|I follow)(.*) within "([^"]+)"$/ do |step, selector|
  within(selector) do
    Then(step)
  end
end