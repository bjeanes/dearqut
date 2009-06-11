class ActiveRecord::Errors
  def delete(key)
    @errors.delete(key)
    @errors.delete(key.to_s)
  end
end