class User < TwitterAuth::GenericUser
  
  # For non-twitter users to login
  def self.authenticate(login, password)
    User.find_by_login(login).authenticate(password)
  rescue
    nil
  end
  
  def authenticate(password)
    # TODO check password field
    self 
  end
  
end
