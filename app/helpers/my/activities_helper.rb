module My
  module ActivitiesHelper
    def render_activity(activity)
      content_tag(:div, :class => "activity#{cycle('', ' alt')}") do
        target = activity.target_type.downcase
        partial = "#{target}_#{activity.action}"
        render :partial => partial, :locals => {:activity => activity, target.to_sym => activity.target}
      end
    end
  end
end