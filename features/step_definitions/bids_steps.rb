
Given /the following bids exist/ do |bids_table|
  bids_table.hashes.each do |user|
    Bid.create user
  end
end

Given /that I clean up the bid table/ do
  Bid.delete_all
end

Given /^that I insert the following data to bid table product name "([^"]*)" , buyer "([^"]*)" , bid "([^"]*)"$/ do |e1,e2,e3|
user = User.find_by(email: e2)
post = Post.find_by(item: e1)
Bid.create(:product_id => post.id, :user_id => user.id, :bid => e3 )
end
