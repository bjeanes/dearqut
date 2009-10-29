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

  validates_format_of       :email, :with => EmailRegex, :unless => :staff?, :allow_nil => true, :allow_blank => true, :message => "must be a valid email address"
  validates_format_of       :email, :with => StaffEmailRegex, :if => :staff?, :on => :create, :message => "must be a QUT staff email address"
  
  named_scope :staff, :conditions => {:staff => true}
  named_scope :verified_staff, :conditions => {:staff => true, :staff_status_confirmed => true}
  named_scope :unverified_staff, :conditions => {:staff => true, :staff_status_confirmed => false}
  
  attr_protected :admin, :staff_status_confirmed
  
  before_create :populate_oauth_user
  
  def to_s
    protected? ? "Anonymous" : name_for_display
  end

  def name_for_display
    name.blank? || name == login ? login_for_display : name
  end
  
  def login_for_display
    "#{'@' if twitter_id?}#{login}"
  end
  
  def verified_staff?
    staff? && staff_status_confirmed?
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
    
  def approve_as_staff!
    update_attribute(:staff_status_confirmed, true) if staff?
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

          self.login             = user_info['screen_name']
          self.location          = user_info['location']
          self.name              = user_info['name']
          self.description       = user_info['description']
          self.twitter_id        = user_info['id']
          self.profile_image_url = user_info['profile_image_url']
          self.url               = user_info['url']
          self.protected         = user_info['protected']
        end
      end
      
      true
    end
end
