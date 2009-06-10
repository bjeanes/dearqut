require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Message do
  describe "#convert_hash_tags_to_tags" do
    it "should not modify the body when there are no tags" do
      message = Message.new
      message.body = "asingleword"
      message.send :convert_hash_tags_to_tags
      
      message.body.should == "asingleword"
    end
    
    describe "with hash inside another word" do
      before do
        @message = Message.new
        @message.body = "http://a.url.com/with/#anchor is #cool"
      end
      
      describe '' do
        before do
          @tags = @message.send :extract_tags
        end
        
        it "should not detect hash-tags when hash is in middle of another word" do
          @tags.should_not include("anchor")
        end

        it "should detect hash-tags when they are their own word" do
          @tags.should include("cool")
        end
      end
      
      it "should not remove the hash from the middle of the word" do
        @message.send :replace_hash_tags
        @message.body.should == "http://a.url.com/with/#anchor is cool"
      end
    end
  end
  
  describe "#strip_and_chomp_body" do
    it "should get rid of any whitespace on either end of a message" do
      message = Message.new
      message.body = " Google!   "
      message.send :strip_and_chomp_body
      
      message.body.should == "Google!"
    end
    
    it "should get rid of any new lines at end of message" do
      message = Message.new
      message.body = " Google!   \r\n"
      message.send :strip_and_chomp_body
      
      message.body.should == "Google!"
    end
    
    it "should set empty string if body is nil" do
      message = Message.new
      message.send :strip_and_chomp_body
      
      message.body.should == ""
    end
    
    it "should not modify the body when there is a single word" do
      message = Message.new
      message.body = "asingleword"
      message.send :strip_and_chomp_body
      
      message.body.should == "asingleword"
    end
  end
end