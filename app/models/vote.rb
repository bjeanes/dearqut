class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  validates_presence_of   :message_id, :value, :ip, :user_agent, :session_id
  validates_inclusion_of  :value, :in => [-1, 1]

  validates_uniqueness_of :user_id,    :scope => :message_id, :allow_blank => true
  validates_uniqueness_of :session_id, :scope => :message_id, :if => :anonymous?
  validates_uniqueness_of :user_agent, :scope => [:message_id, :ip], :if => :anonymous?

  validates_format_of :user_agent, :with => /^((?!curl).)*$/, :message => "must be a browser"

  named_scope :positive, :conditions => "value > 0"
  named_scope :negative, :conditions => "value < 0"
  
  after_save    :update_message_rating_cache
  after_destroy :update_message_rating_cache
  
  attr_accessible # nothing
  
  def agreed?
    value > 0
  end
  
  def disagreed?
    value < 0
  end
  
  def direction?(direction)
    send "#{direction}d?"
  end
  
  def anonymous?
    !user_id?
  end
  
  private
  
    def update_message_rating_cache
      message.send :update_rating!
    end
    
end
