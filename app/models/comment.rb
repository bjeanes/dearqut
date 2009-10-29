class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message, :counter_cache => true
  
  validates_presence_of :body, :message_id
  
  attr_accessible :body, :private, :staff
  
  before_create :check_verified_staff
  after_create :set_message_commented_at
  
  acts_as_snook
  
  def author
    anonymous? ? "Anonymous" : user.to_s
  end
  
  def anonymous?
    user.nil? || private? || user.protected?
  end
  
  def get_keywords
    @keywords ||= KeywordFinder.get_keywords(body)
  end
  
  private
  
  def set_message_commented_at
    message.last_commented_at = Time.now
    message.save(false)
  end
  
  def check_verified_staff
    staff = staff? && user && user.verified_staff?
    true
  end
  
end