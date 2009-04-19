module DearqutHelper
  def current_user
    controller.current_user
  rescue
    nil
  end
end

World(DearqutHelper)