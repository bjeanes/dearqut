class VotesController < ApplicationController
  before_filter :build_vote
  
  def up
    @vote.value = 1
    save_vote
  end
  
  def down
    @vote.value = -1
    save_vote
  end
  
  protected
  
    def build_vote
      message = Message.find(params[:message_id])
      @vote = message.votes.build(:user => current_user)
    end
    
    def save_vote
      render :text => (@vote.save ? "OK" : "Damn")
    end
end
