class Message < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :body
  
  before_save :set_twitter_field_to_false
  
  def author
    anonymous? ? "Anonymous" : user.to_s
  end

  # If sent via DM, lets make it Anonymous by default. All other 
  # messages are public, unless the user has a protected profile,
  # or of course they really were anonymous when creating message.
  def anonymous?
    private? || user.nil? || user.protected?
  end
  
  protected
    def set_twitter_field_to_false
      self.twitter ||= false
      true
    end
end
