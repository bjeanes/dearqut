class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  validates_presence_of :user_id, :message_id, :up
  
  # Allow nil user_id so that anonymous people can vote (will need to work on restricting this based on session)
  validates_uniqueness_of :user_id, :scope => :message_id, :allow_nil => true
  
  def down?
    !up?
  end
end
