Then /^the message will be under the name "([^\"]*)"$/ do |author|
  Message.last.author.should == author
end