Then /^the message will be under the name "([^\"]*)"$/ do |author|
  Message.last.author.should == author
end

Given /^a message titled "([^\"]*)" with (\d+) agrees and (\d+) disagrees$/ do |title, agrees, disagrees|
  Message.make(:body => title, :positive_vote_count => agrees, :negative_vote_count => disagrees)
end

Given /^a message titled "([^\"]*)"$/ do |title|
  Message.make(:body => title)
end

Given /^I am logged in as admin$/ do
  Given %{there is the following user},
   %{
   | login | password | admin |
   | admin | secret   | true  |
   }
  When  %{I go to the admin page}
  And   %{I fill in "Username" with "admin"}
  And   %{I fill in "Password" with "secret"}
  And   %{I press "Login"}
  Then  %{I should be on the admin page}
  Given %{I am logged in as admin}
end
