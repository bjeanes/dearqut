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
  
  context "poster and author" do
    before do
      @user         = User.new(:login => "person name")
      @comment      = Comment.new
      @comment.user = @user
    end
    
    subject { @comment }
    
    describe "#author" do
      subject { @comment.author }
      
      it "returns the author name" do
        should == "person name"
      end
    
      it "returns 'Anonymous' when there is no user" do
        Comment.new.author.should == 'Anonymous'
      end
    
      it "returns 'Anonymous' when the user is set to protected mode" do
        @user.protected = true
        should == "Anonymous"
      end
      
      it "returns 'Anonymous' when the comment is set to private" do
        @comment.private = true
        should == "Anonymous"
      end
    end
    
    describe "#anonymous?" do
      it "is true when the user is anonymous" do
        @user.protected = true
        should be_anonymous
      end
      
      it "is true when comment is private" do
        subject.private = true
        should be_anonymous
      end
      
      it "is true when there is no user" do
        Comment.new.should be_anonymous
      end
    end
  end
end
