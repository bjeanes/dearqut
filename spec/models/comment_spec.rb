require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  context "updating parent message" do
    freeze_time!
    
    before do
      @message         = Message.create(:body => "Sup", :last_commented_at => nil)
      @comment         = @message.comments.build(:body => "oh yeaaaah")
      @comment.message = @message # fucking lack of identity map
    end
    
    subject { @message }
    
    it "sets the last_commented_at to the current time" do      
      @comment.save.should be_true
      @message.last_commented_at.should eql(Time.now)
    end
  end
end
