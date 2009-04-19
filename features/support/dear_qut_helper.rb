module DearQutHelper
  def current_user
    controller.current_user
  rescue
    nil
  end
  
  def create_user(user = "leet", password = "h4x0r")
    User.find_by_login(user) || User.create(:login => user, :password => password)
  end
end

World(DearQutHelper)