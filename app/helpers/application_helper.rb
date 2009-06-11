# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def anonymous?
    controller.send :anonymous?
  end
  
  def admin?
    controller.send :admin?
  end
end
