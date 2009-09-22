class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message, :counter_cache => true
  
  validates_presence_of :body, :message_id
  
  attr_accessible :body
  
  after_create :set_message_commented_at
  
  def author
    (user || "Anonymous").to_s
  end
  
  def anonymous?
    user.nil?
  end
  
  private
  
  def set_message_commented_at
    message.last_commented_at = Time.now
    message.save(false)
  end
end