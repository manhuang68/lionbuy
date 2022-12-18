# LionBuy

Sell your used goods on Columbia's campus! 

Deployment at https://lionbuy.herokuapp.com/

Github repo: https://github.com/manhuang68/lionbuy/

Demo link: https://youtu.be/OH3TTk5WJu4


## Team members 

\* Huifeng Wu, hw2910
\* Zelin Wang, zw2852
\* Man Huang Ho, mh4142



## Instructions

For **Project Iteration 1**, we have identified our minimal features, as follows:

- User Login / Authentication
- User Registration
- User Logout sessions
- Post Display
- Item Manipulations (eg. price filtering, keyword searching, and categorization)

### User Login

- You can log onto our premium LionBuy website if you have a registered account
- Inconsistent email or password will be prompted "Invalid Credentials" 

### User Registration

- Users can only register an account with @columbia.edu or @barnard.edu affiliated email addresses
- Passwords have to match with the retyped one 
- Fields cannot be empty
- Already registered account cannot be double registered

### User Logout

- Users can use the logout button on the top left of our home page

### Item manipulation

- Price filters: users can set a min and max price to find items that fulfill their bugets
- Categorization: can find items with correct categories
- Keyword search: can find posts whose description or titles include the keyword.



For **Project Iteration 2**, we have identified our main features, as follows:

- User History
- My Posts
- Seller Operation
- Buyer Behaviour 

### User History

- Users can use "Order history" or "Selling summary" buttons to inspect their past sales or orders

### My Posts 

- List all active posts for the current users
- One can check out if others bid on his/her goods, and monitor the status

### Seller Operation

- Sellers can edit their posts on my posts page 
- Sellers can delete their posts on my posts page 
- Sellers can accept a deal if being satisfied with the current bid on my posts page 

### Buyer Behaviour 

- On desired items, one can click into the details on its associated post
  - Either input a price to bid
  - Or buy it now directly to secure the item



For **Project Launch**, we have identified our complete features, as follows:

### Pagination 

- Users can browse through difference pages with our order history, selling summary and home features

### Image

- Users now can upload images when making posts for their selling items

### Notification 

- Sellers are notified either when someone bids on his/her active items, or someone directly use "buy it now" to acquire the items
- Buyers are notified when his/her bids are accepted by the corresponding sellers



### Setup Your Working Environment

```
bundle install --without production 
bundle exec rake db:setup 
bundle exec rake db:migrate
bundle exec rake db:test:prepare
rails server -b 0.0.0.0
```



## Cucumber and  Rspec Tests

```
rake cucumber
rake spec
```

