class Message < ActiveRecord::Base
  belongs_to :user
  has_many   :votes
  
  validates_presence_of :body, :message => "^Please enter a message."
  validates_uniqueness_of :tweet_id, :allow_blank => true
  
  def author
    anonymous? ? "Anonymous" : user.to_s
  end
  
  def rating
    @rating ||= votes.sum(:value)
  end

  # If sent via DM, lets make it Anonymous by default. All other 
  # messages are public, unless the user has a protected profile,
  # or of course they really were anonymous when creating message.
  def anonymous?
    private? || user.nil? || user.protected?
  end
end
