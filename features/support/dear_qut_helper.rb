module DearQutHelper
  def current_user
    controller.send :current_user
  end
  
  def should_be_logged_in
    controller.should be_logged_in
  end
  
  def create_user(login = "leet", password = "password", admin = false)
    User.find_by_login(login) || begin
      u = User.new(:password => password, :password_confirmation => password)
      u.login = login
      u.email = "#{login}@#{login}.com"
      u.admin = admin
      u.save!
      u
    end
  end
  
  def login(login, password)
    post_via_redirect '/user_sessions', :user_session => 
      {:login => login, :password => password}
  end
end

World(DearQutHelper)