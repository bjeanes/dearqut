Then /^the message will be under the name "([^\"]*)"$/ do |author|
  Message.last.author.should == author
end

Given /^a message titled "([^\"]*)" with (\d+) agrees and (\d+) disagrees$/ do |title, agrees, disagrees|
  Message.make(:body => title, :positive_vote_count => agrees, :negative_vote_count => disagrees)
end
