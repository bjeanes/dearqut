class VotesController < ApplicationController
  before_filter :build_vote
  skip_before_filter :verify_authenticity_token
  
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
      message          = Message.find(params[:message_id])
      @vote            = message.votes.build
      @vote.user       = current_user
      @vote.session_id = session[:session_id]
    end
    
    def save_vote
      success = @vote.save
      
      render :json => [{
        :success        => success,
        :id             => @vote.message_id,
        :rating         => @vote.message.rating,
        :positive_count => @vote.message.positive_vote_count,
        :negative_count => @vote.message.negative_vote_count,
        :value          => @vote.value
      }]
    end
end
