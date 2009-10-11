When /^I eval "([^\"]+)"$/ do |code|
  eval(code)
end

When /^I dump the page$/ do
  save_and_open_page
end