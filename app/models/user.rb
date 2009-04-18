class User < TwitterAuth::GenericUser
  has_many :messages
  has_many :comments
  has_many :votes
  
  attr_accessor :password
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :password, :within => 6..40, :if => :password_required?
  before_save :encrypt_password
  
  def to_s
    protected? ? "Anonymous" : name_for_display
  end
  
  def twitter?
    !access_token.nil?
  end
  
  def name_for_display
    name.blank? ? login_for_display : name
  end
  
  def login_for_display
    "#{'@' if twitter?}#{login}"
  end
  
  def self.find_or_create_by_twitter_user(user)
    find_by_login(user.screen_name) || begin
      options = {
        :location => user.location,
        :login => user.screen_name,
        :description => user.description, 
        :name => user.name,
        :profile_image_url => user.profile_image_url,
        :url => user.url,
        :protected => user.protected,
      }

      create(options)
    end
  end
  
  # For non-twitter users to login
  def self.authenticate(login, password)
    User.find_by_login(login).authenticate(password)
  rescue NoMethodError
    nil
  end
  
  protected
    # Encrypts the password with the user salt
    def encrypt(password)
      self.class.password_digest(password, salt)
    end
  
    def authenticated?(password)
      crypted_password == encrypt(password)
    end
  
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = self.class.make_token if new_record?
      self.crypted_password = encrypt(password)
    end
  
    def password_required?
      !twitter? && (crypted_password.blank? || !password.blank?)
    end
  
  
    class << self
      def password_digest(password, salt)
        # random chars to start the encryption:
        key = digest = '54bbcff1f33fb6e7a250df37a4211d509fe6f4a4'
        10.times { digest = secure_digest(digest, salt, password, key) }
        digest
      end
    
      def secure_digest(*args)
        Digest::SHA1.hexdigest(args.flatten.join('--'))
      end

      def make_token
        secure_digest(Time.now, (1..10).map{ rand.to_s })
      end
    end
end
