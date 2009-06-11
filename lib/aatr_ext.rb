class Tag < ActiveRecord::Base
  default_scope :order => "name ASC"
  named_scope :popular, :order => "taggings_count DESC, name ASC"
  named_scope :search, lambda {|q| {:conditions => ["name LIKE ?", "%#{q}%"]} }
  named_scope :limit, lambda {|l| {:limit => l} }
end