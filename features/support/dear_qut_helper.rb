module DearQutHelper
  def current_user
    controller.current_user
  rescue
    nil
  end
  
  def create_user(login = "leet", password = "h4x0rk1d")
    User.find_by_login(login) || begin
      u = User.new(:password => password, :password_confirmation => password)
      u.login = login
      u.save!
      u
    end
  end
end

World(DearQutHelper)