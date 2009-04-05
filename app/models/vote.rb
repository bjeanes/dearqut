class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  validates_presence_of :user_id, :message_id, :up
  validates_uniqueness_of :user_id, :scope => :message_id
  
  def down?
    !up?
  end
end
