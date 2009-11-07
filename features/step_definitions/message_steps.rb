When /^I ((?:dis)?agree) with the message$/ do |action|
  within("form.#{action}") do
    When "I press #{action.titleize.inspect}"
  end
end

Then /^the message will be under the name "([^\"]*)"$/ do |author|
  Message.last.author.should == author
end

Given /^a message titled "([^\"]*)" with (\d+) agrees and (\d+) disagrees$/ do |title, agrees, disagrees|
  Message.make(:body => title, :positive_vote_count => agrees, :negative_vote_count => disagrees)
end

Given /^a message titled "([^\"]*)"$/ do |title|
  Message.make(:body => title)
end

Given /^a message titled "([^\"]*)" by user "([^\"]*)"$/ do |title, user|
  Message.make(:body => title, :user => User.make(:login => user))
end


Given /^I am logged in as admin$/ do
  Given %Q{there is the following user only}, table([
    %w{login password admin},
    %w{admin secret true}
    ])
  
  When  %{I go to the admin page}
  And   %{I fill in "Username" with "admin"}
  And   %{I fill in "Password" with "secret"}
  And   %{I press "Login"}
  Then  %{I should be on the admin page}
  Given %{I am logged in as admin}
end

Then /^I should see the following suggested tags:$/ do |table|
  actual_table = current_dom.xpath("//ul[@id='suggested_tags']/li/text()").to_a.map{|item| [item.to_s]}
  table.diff!(actual_table)
end
