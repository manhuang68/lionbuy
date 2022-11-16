# LionBuy

Sell your used goods on Columbia's campus! 

Deployment at https://lionbuy.herokuapp.com/

Github repo: https://github.com/manhuang68/lionbuy/

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

For **Project Iteration 2**, we have identified our main features, as follows:

- User History
- My Posts
- Seller Operation
- Buyer Behaviour 

### Setup Your Working Environment

```
bundle install --without production 
bundle exec rake db:setup 
bundle exec rake db:migrate
bundle exec rake db:test:prepare
rails server -b 0.0.0.0
```

### User History for sales and orders

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

## Cucumber and  Rspec Tests

```
rake cucumber
rake spec
```

