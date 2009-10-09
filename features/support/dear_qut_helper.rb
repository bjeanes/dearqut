module DearQutHelper
  def current_user
    controller.send :current_user
  end
  
  def should_be_logged_in
    controller.should be_logged_in
    current_user.should_not be_nil
  end
  
  def create_user(login = "leet", password = "h4x0rk1d", admin = false)
    User.find_by_login(login) || begin
      u = User.new(:password => password, :password_confirmation => password)
      u.login = login
      u.creating_normal_user = true
      u.admin = admin
      u.save!
      u
    end
  end
end

World(DearQutHelper)