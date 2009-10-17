class ActivityObserver < ActiveRecord::Observer
  observe :vote, :comment, :message

  def after_create(record)
    Activity.create(
      :target => record,
      :action => "created",
      :user => record.user,
      :created_at => record.created_at)
  end
  
  def after_update(record)
    Activity.create(
      :target => record,
      :action => "updated",
      :user => record.user,
      :created_at => record.created_at)
  end
  
  def after_destroy(record)
    Activity.create(
      :target => record,
      :action => "deleted",
      :user => record.user,
      :created_at => record.created_at)
  end
end