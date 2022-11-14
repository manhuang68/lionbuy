
Given /the following bids exist/ do |bids_table|
  bids_table.hashes.each do |user|
    Bid.create user
  end
end

Given /that I am out of session/ do
  session[:user_id] = nil
  session[:fname] =  nil
  session[:lname] =  nil 
end
