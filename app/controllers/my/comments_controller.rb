module My
  class CommentsController < BaseController

    def index
      @comments = current_user.comments.paginate(:page => params[:page])
    end

  end
end