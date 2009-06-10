require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Message do
  describe "#convert_hash_tags_to_tags" do
    it "should not modify the body when there are no tags" do
      message = Message.new
      message.body = "asingleword"
      message.send :convert_hash_tags_to_tags
      message.body.should == "asingleword"
    end
  end
  
  describe "#strip_and_chomp_body" do
    it "should not modify the body when there is a single word" do
      message = Message.new
      message.body = "asingleword"
      message.send :strip_and_chomp_body
      message.body.should == "asingleword"
    end
  end
end