class Message < ActiveRecord::Base
  default_scope :order => 'created_at'
  
  belongs_to :user
  has_many   :votes,    :dependent => :destroy
  has_many   :comments, :dependent => :destroy
  
  validates_presence_of :body, :message => "^Please enter a message."
  validates_presence_of :tweet_id, :on => :create, :if => :twitter?
  validates_uniqueness_of :tweet_id, :allow_blank => true
  
  before_save  :convert_hash_tags_to_tags
  before_save  :strip_and_chomp_body
  after_create :create_initial_vote_for_author, :unless => :guest?

  attr_accessor :twitter
  
  attr_accessible :body
  
  acts_as_taggable
  
  # If sent via DM, lets make it Anonymous by default. All other 
  # messages are public, unless the user has a protected profile,
  # or of course they really were anonymous when creating message.
  def anonymous?
    private? || guest? || user.protected?
  end
  
  def guest?
    user.nil?
  end
  
  def author
    anonymous? ? "Anonymous" : user.to_s
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
  
  def twitter?
    tweet_id? || !!@twitter
  end
  
  private
  
    # This is called from after_save and after_destroy on Vote
    def update_rating!
      # not using count because lates some votes might be something other than +/- 1
      self.positive_vote_count = votes.positive.sum(:value).abs
      self.negative_vote_count = votes.negative.sum(:value).abs
      self.rating              = votes.sum(:value)
      save!
    end
    
    def convert_hash_tags_to_tags
      self.tag_list = body.to_s.scan(/(?:^|\s)#(\w+)/).flatten.join(" ").downcase
      
      # not sure that it should always do this (perhaps 
      # just when the hash tag is at the end of the message):
      self.body = body.to_s.gsub(/#(\w+)/, '\1')
      
      true
    end
    
    def strip_and_chomp_body
      self.body = body.to_s.chomp.strip.gsub!(/[\ \t]+/, ' ')
      true
    end
    
    # When a user creates a message, we assume they want to vote
    # for the message
    def create_initial_vote_for_author
      votes.create(:user => user, :value => 1)
    end
end
