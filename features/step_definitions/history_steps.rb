Given /the following order histories exist/ do |oh_table|
  oh_table.hashes.each do |h|
    History.create h
  end
end

Given /that I clean up the history table/ do
  History.delete_all
end


Given /^that I insert the following data to history table product name "([^"]*)" , buyer "([^"]*)" , price "([^"]*)"$/ do |e1,e2,e3|
  user = User.find_by(email: e2)
  post = Post.find_by(item: e1)
  History.create(:product_id => post.id, :buyer_id => user.id, :price => e3 )
end