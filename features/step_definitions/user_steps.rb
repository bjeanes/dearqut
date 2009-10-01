Given /^there is the following user$/ do |table|
  table.hashes.each do |user_details|
    user                       = User.new(user_details)
    user.creating_normal_user  = true
    user.password_confirmation = user_details["password"]
    user.admin                 = user_details["admin"] == "true" ? true : false
    user.save!
  end
end
