class VotesController < ApplicationController
  before_filter :build_vote
  
  def agree
    @vote.value = 1
    save_vote
  end
  
  def disagree
    @vote.value = -1
    save_vote
  end
  
  protected
  
    def build_vote
      message          = Message.find(params[:message_id])
      @vote            = message.votes.build
      @vote.user       = current_user || nil
      @vote.session_id = session[:session_id]
    end
    
    def save_vote
      @vote.ip          = request.remote_ip
      @vote.user_agent  = request.env["HTTP_USER_AGENT"]
      success           = @vote.save rescue false
      
      respond_to do |wants|
        wants.js do
          vote              = {
            :success        => success,
            :id             => @vote.message_id,
            :rating         => @vote.message.rating,
            :positive_count => @vote.message.positive_vote_count,
            :negative_count => @vote.message.negative_vote_count,
            :value          => @vote.value
          }
      
          vote[:errors] = @vote.errors.full_messages unless success
      
          render :json => [vote]
        end
        
        wants.html do
          flash[:error] = "Could not place vote (already voted?)" unless success
          redirect_to :back
        end
      end
    end
end
