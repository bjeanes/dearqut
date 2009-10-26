module My
  class MessagesController < BaseController

    def index
      @messages = current_user.messages.paginate(:order => "created_at DESC", :page => params[:page])
      @grouped_messages = @messages.group_by {|m| m.updated_at.strftime("%d-%m-%Y")}
    end

  end
end