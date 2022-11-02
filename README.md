# LionBuy

Sell your used goods on Columbia's campus! 

Deployment at https://lionbuy.herokuapp.com/.

Github repo: https://github.com/manhuang68/lionbuy/

## Team members 

\* Huifeng Wu, hw2910
\* Zelin Wang, zw2852
\* Man Huang Ho, mh4142

## Instructions

For Project Iteration 1, we have identified our minimal features, as follows:

- User login / authentication
- User registration
- User logout sessions
- Post display
- Item manipulations such as price filtering, keyword searching, and categorization

### Setup Your Working Environment

```
bundle install --without production 
rake db:setup *# shorthand for db:create, db:migrate, db:seed* 
rails server -b 0.0.0.0
```

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

## Cucumber and  Rspec Tests

```
rake cucumber
rake spec
```

