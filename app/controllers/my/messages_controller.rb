module My
  class MessagesController < BaseController

    def index
      @messages = current_user.messages.paginate(:page => params[:page])
    end

  end
end