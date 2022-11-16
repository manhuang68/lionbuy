
Given /the following bids exist/ do |bids_table|
  bids_table.hashes.each do |user|
    Bid.create user
  end
end