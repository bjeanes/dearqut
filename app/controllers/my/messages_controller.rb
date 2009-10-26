module My
  class MessagesController < BaseController

    def index
      @messages = current_user.messages.paginate(:order => "updated_at", :page => params[:page])
      @grouped_messages = @messages.group_by {|m| m.updated_at.strftime("%Y-%m-%d")}
    end

  end
end