module My
  class ActivityController < BaseController
    def index
      @activities = current_user.activities.paginate(:page => params[:page])
    end

  end
end