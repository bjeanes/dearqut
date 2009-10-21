class Tag < ActiveRecord::Base
  default_scope :order => "name ASC"
  named_scope :popular, :order => "taggings_count DESC, name ASC"
  named_scope :search, lambda {|q| {:conditions => ["name LIKE ?", "%#{q}%"]} }
  named_scope :limit, lambda {|l| {:limit => l} }
  
  def to_param
    if name.parameterize == name.downcase
      name
    else
      "#{id}-#{name.parameterize}"
    end
  end
  
  def self.find_by_id_or_name(id_or_name)
    first(:conditions => ['tags.id = :tag OR tags.name = :tag', {:tag => id_or_name}])
  end
  
end