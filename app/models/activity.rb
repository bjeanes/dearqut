class Activity < ActiveRecord::Base
  default_scope :order => 'created_at desc'
  
  belongs_to :target, :polymorphic => true
  belongs_to :user
end
