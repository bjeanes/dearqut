class Message < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :body
  
  def author
    (user || "Anonymous").to_s
  end
end
