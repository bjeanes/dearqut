class User < ActiveRecord::Base
  EmailRegex      = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  StaffEmailRegex = /^.*?@qut\.edu\.au$/
  
  acts_as_authentic do |config| 
    config.transition_from_restful_authentication = true
    config.validate_email_field                   = false # we'll do this ourselves
  end
    
  has_many :messages,   :dependent => :nullify
  has_many :comments,   :dependent => :nullify
  has_many :votes,      :dependent => :destroy
  has_many :activities, :dependent => :destroy

  validates_uniqueness_of   :email, :allow_nil => true
  validates_format_of       :email, :with => EmailRegex, :unless => :staff?, :allow_nil => true, :allow_blank => true, :message => "must be a valid email address"
  validates_format_of       :email, :with => StaffEmailRegex, :if => :staff?, :on => :create, :message => "must be a QUT staff email address"
  
  attr_protected :admin, :staff, :staff_status_confirmed
  
  after_create :populate_oauth_user
  
  def to_s
    protected? ? "Anonymous" : name_for_display
  end

  def name_for_display
    name.blank? || name == login ? login_for_display : name
  end
  
  def login_for_display
    "#{'@' if twitter_id?}#{login}"
  end
  
  def voted?(message)
    id = message =~ /\d+/ ? message : message.id
    votes.first(:conditions => ["message_id = ?", id])
  end
  
  def agreed?(message)
    voted?(message).agreed?
  end
  
  def disagreed?(message)
    voted?(message).disagreed?
  end
  
  def twitter?
    !twitter_id.nil?
  end
  
  def self.find_or_create_by_twitter_user(user)
    find_by_login(user.screen_name) || begin
      options = {
        :twitter_id => user.id,
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
  
  def self.find_by_login_or_email(login)
    find_by_login(login) || find_by_email(login)
  end
  
  protected
  
    def password_required?
      !twitter? && (crypted_password.blank? || !password.blank?)
    end
    
    def populate_oauth_user
      unless oauth_token.blank?
        @response = UserSession.oauth_consumer.request(:get, '/account/verify_credentials.json',
        access_token, { :scheme => :query_string })
        case @response
        when Net::HTTPSuccess
          user_info = JSON.parse(@response.body)
          
          self.attributes = user_info

          # self.login             = user_info['login']
          # self.location          = user_info['location']
          # self.name              = user_info['name']
          # self.description       = user_info['description']
          # self.twitter_id        = user_info['id']
          # self.profile_image_url = user_info['profile_image_url']
          # self.url               = user_info['url']
          # self.protected         = user_info['protected']
        end
      end
    end
end
