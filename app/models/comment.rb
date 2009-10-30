class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message, :counter_cache => true
  
  validates_presence_of :body, :message_id
  
  attr_accessible :body, :private, :staff
  
  validate :ensure_staff_comments_cannot_be_anonymous

  before_create :check_verified_staff
  after_create :set_message_commented_at
  
  acts_as_snook :comment_belongs_to => "message", :ham_comments_count_field => :ham_comments_count
  
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
  
  def ensure_staff_comments_cannot_be_anonymous
    errors.add_to_base("Staff comments cannot be anonymous") if private? && staff?
  end
  
  
end