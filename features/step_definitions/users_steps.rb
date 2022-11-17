Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Given /that I am out of session/ do
  session[:user_id] = nil
  session[:fname] =  nil
  session[:lname] =  nil
end

Given /that I clean up the user table/ do
  User.delete_all
end
