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
      @vote = message.votes.build
      @vote.user = current_user
    end
    
    def save_vote
      success      = @vote.save
      id           = @vote.message_id
      rating       = @vote.message.rating
      value        = @vote.value
      
      render :json => "[{'id': #{id}, 'rating': #{rating}, 'success': #{success.inspect}, 'value': #{value}}]"
    end
end
