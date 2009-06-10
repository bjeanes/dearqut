class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message, :counter_cache => true
  
  validates_presence_of :body, :message_id
  
  attr_accessible :body
  
  def author
    (user || "Anonymous").to_s
  end
  
  def anonymous?
    user.nil?
  end
end
