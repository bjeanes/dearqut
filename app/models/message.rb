class Message < ActiveRecord::Base
  belongs_to                       :user
  belongs_to                       :campus
  belongs_to                       :faculty
                                   
  has_many                         :votes,    :dependent => :destroy
  has_many                         :comments, :dependent => :destroy
  has_many                         :flags,    :dependent => :destroy
                                   
  validates_presence_of            :body, :message => "^Please enter a message."
  validates_presence_of            :tweet_id, :if => :twitter?
  validates_uniqueness_of          :tweet_id, :allow_blank => true
                                   
  before_save                      :convert_hash_tags_to_tags
  before_save                      :strip_and_chomp_body
  after_create                     :create_initial_vote_for_author, :unless => :guest?

  named_scope :not_moderated,      :conditions => {:moderated => false}
  named_scope :needs_moderation,   :conditions => ['moderation_status <> ? AND moderated = ?', 'ham', false], 
                                   :order => :moderation_status
  named_scope :culled,             :conditions => ['moderation_status = ?', 'culled']
  
  named_scope :search,             lambda { |query| {:conditions => ['messages.body LIKE ?', "%#{query}%"]} }
  named_scope :popular,            :order => 'rating DESC, tweet_id DESC'
  named_scope :newest,             :order => 'created_at DESC, tweet_id DESC'
  named_scope :most_commented,     :order => 'comments_count DESC, tweet_id DESC'
  named_scope :most_controversial, :order => '(1 / ABS(positive_vote_count - negative_vote_count)) * (positive_vote_count + negative_vote_count) DESC'
  named_scope :latest_commented,   :conditions => 'last_commented_at IS NOT NULL', 
                                   :order => 'last_commented_at DESC, tweet_id DESC'
                                   
  attr_accessor                    :twitter
  attr_accessible                  :body, :tag_list, :campus_id, :faculty_id, :private
  acts_as_taggable
  acts_as_snook                    :spam_status_field => :moderation_status
  
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
    self[:user_id] == user.id
  end
  
  def rating
    self[:rating] || 0
  end
  
  def self.random
    first(:offset => rand(count))
  end
  
  def qut?
    ip =~ /^131\.181\./
  end
  
  def cull!
    update_attributes(:status => 'culled', :moderated => true)
  end
  
  def self.update_last_commented_at
    connection.execute(
      %Q[UPDATE messages 
         SET last_commented_at =
           (SELECT created_at 
            FROM comments 
            WHERE message_id = messages.id 
            ORDER BY created_at DESC 
            LIMIT 1)])
  end
  
  def self.update_ham_comments_count
    connection.execute(
      %Q[UPDATE messages 
         SET ham_comments_count =
           (SELECT COUNT(*) 
            FROM comments 
            WHERE message_id = messages.id 
            AND comments.spam_status = 'ham')])
  end
  
  def twitter?
    tweet_id? || !!@twitter
  end
  
  def tag_list=(tags)
    tags = tags.join(" ") if tags.respond_to? :join
    super(tags)
  end
  
  def suggested_tags?
    !suggested_tags.empty?
  end
  
  def suggested_tags
    @suggested_tags ||= KeywordFinder.get_keywords(body).sort.uniq
    @suggested_tags - existing_tags
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
      tags = existing_tags + extract_tags
      self.tag_list = tags.uniq * ' '
      replace_hash_tags
      true
    end
    
    def strip_and_chomp_body
      self.body = body.to_s.chomp.strip.gsub(/[\ \t]+/, ' ')
      true
    end
    
    def existing_tags
      self.tag_list.split(/\s+/)
    end
    
    def extract_tags
      self.body.to_s.scan(/(?:^|\s)#(\w+)/).flatten
    end
    
    def replace_hash_tags
      # not sure that it should always do this (perhaps 
      # just when the hash tag is at the end of the message):
      self.body = body.to_s.gsub(/(^|\s)#(\w+)/, '\1\2')
    end
    
    # When a user creates a message, we assume they want to vote
    # for the message
    def create_initial_vote_for_author
      votes.create(:user => user, :value => 1)
    end
    
end
