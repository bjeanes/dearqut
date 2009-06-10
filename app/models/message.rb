class Message < ActiveRecord::Base
  default_scope :order => 'created_at'
  
  belongs_to :user
  has_many   :votes
  has_many   :comments
  
  validates_presence_of :body, :message => "^Please enter a message."
  validates_uniqueness_of :tweet_id, :allow_blank => true
  
  after_create :create_initial_vote_for_author, :unless => :guest?
  
  attr_accessible :body
  
  def author
    anonymous? ? "Anonymous" : user.to_s
  end

  # If sent via DM, lets make it Anonymous by default. All other 
  # messages are public, unless the user has a protected profile,
  # or of course they really were anonymous when creating message.
  def anonymous?
    private? || guest? || user.protected?
  end
  
  def guest?
    user.nil?
  end
  
  def author?(user)
    params[:user] == user
  end
  
  def rating
    self[:rating] || 0
  end
  
  def self.random
    first(:offset => rand(count))
  end
  
  private
  
    # This is called from after_save and after_destroy on Vote
    def update_rating!
      update_attributes({
        # not using count because lates some votes might be something other than +/- 1
        :positive_vote_count => votes.positive.sum(:value).abs,
        :negative_vote_count => votes.negative.sum(:value).abs,
        :rating              => votes.sum(:value)
      })
    end
    
    # When a user creates a message, we assume they want to vote
    # for the message
    def create_initial_vote_for_author
      votes.create(:user => user, :value => 1)
    end
end
