class User < ActiveRecord::Base
  acts_as_authentic do |c| 
    c.transition_from_restful_authentication = true 
  end
    
  has_many :messages,   :dependent => :nullify
  has_many :comments,   :dependent => :nullify
  has_many :votes,      :dependent => :destroy
  has_many :activities, :dependent => :destroy

  validates_uniqueness_of   :email, :allow_nil => true
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :unless => :staff?, :allow_blank => true, :message => "must be a valid email address"
  validates_format_of       :email, :with => /^.*?@qut\.edu\.au$/, :if => :staff?, :on => :create, :message => "must be a QUT staff email address"
  
  attr_protected :admin, :staff, :staff_status_confirmed
  
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
  # def self.find_or_create_by_twitter_user(user)
  #   find_by_login(user.screen_name) || begin
  #     options = {
  #       :twitter_id => user.id,
  #       :location => user.location,
  #       :login => user.screen_name,
  #       :description => user.description, 
  #       :name => user.name,
  #       :profile_image_url => user.profile_image_url,
  #       :url => user.url,
  #       :protected => user.protected,
  #     }
  # 
  #     create(options)
  #   end
  # end
  
  protected
  
    def password_required?
      !twitter? && (crypted_password.blank? || !password.blank?)
    end
end
