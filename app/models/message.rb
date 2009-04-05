class Message < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :body
  
  before_save :set_twitter_field_to_false
  
  def author
    (user || "Anonymous").to_s
  end
  
  protected
    def set_twitter_field_to_false
      self.twitter ||= false
    end
end
