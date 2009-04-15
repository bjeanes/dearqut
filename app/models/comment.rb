class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  validates_presence_of :body, :message_id
  
  def author
    (user || "Anonymous").to_s
  end
end
