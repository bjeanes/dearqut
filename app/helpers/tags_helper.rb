module TagsHelper
  def tags_in_use_cloud
    Tag.with_type_scope('Message') { tag_cloud }
  end
end