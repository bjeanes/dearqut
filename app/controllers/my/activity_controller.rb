module My
  class ActivityController < BaseController
    def index
      @activities = current_user.activities.paginate(:page => params[:page])
      @grouped_activities = @activities.group_by {|m| m.created_at.strftime("%d-%m-%Y")}
    end

  end
end