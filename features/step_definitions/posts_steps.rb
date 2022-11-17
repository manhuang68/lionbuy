
Given /the following posts exist/ do |posts_table|
  posts_table.hashes.each do |post|
    Post.create post
  end
end

When /I (un)?check the following categories: (.*)/ do |uncheck, category_list|
  category_list.split(', ').each do |category|
    step %{I #{uncheck.nil? ? '' : 'un'}check "categories_#{category}"}
  end
end

Then /I should see all the posts/ do
  Post.all.each do |post|
    step %{I should see "#{post.item}"}
  end
end

Then /^the seller of "(.*)" should be "(.*)"/ do |e1, e2|
  seller = Post.find_by(item: e1).seller
  expect(seller).to eq e2
end

Given /that I clean up the post table/ do
  Post.delete_all
end
