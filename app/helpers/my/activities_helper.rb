module My
  module ActivitiesHelper
    def render_activity(activity)     
      target = activity.target_type.downcase
      partial = "#{target}_#{activity.action}"
      
      content_tag(:div, :class => "activity #{target} #{cycle('', ' alt')}") do
        render :partial => partial, :locals => {:activity => activity, target.to_sym => activity.target}
      end
    end
  end
end