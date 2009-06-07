class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  validates_presence_of   :user_id, :message_id, :value
  validates_uniqueness_of :user_id, :scope => :message_id #, :allow_blank => true
  validates_inclusion_of  :value, :in => [-1, 1]

  named_scope :positive, :conditions => "value > 0"
  named_scope :negative, :conditions => "value < 0"
  
  after_save    :update_message_rating_cache
  after_destroy :update_message_rating_cache
  
  attr_accessible # nothing
  
  private
  
    def update_message_rating_cache
      message.send :update_rating!
    end
    
end
