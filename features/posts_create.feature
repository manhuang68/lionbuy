# Project Iteration 1

Feature: Post Display

  Here it shows how our users can find posts they like
  by either categorizing, searcing, or filtering

Background: users in database
  Given that I clean up the post table
  Given that I clean up the user table

  Given the following users exist:
  | email            | password | fname  | lname     |
  | 123@columbia.edu | 123      | John   | Ho        |
  | anabel@barnard.edu  | 12345     | Anabel   | Ho        |

  When I go to the signin page
  Then I should see "Log in"
  Then I fill in "email" with "123@columbia.edu"
  Then I fill in "password" with "123"
  And  I press "Sign in"
  Then I should be on the post page

  Given the following posts exist:
  | item                            | description                              | price  | user              | email               | category |
  | Laptop MAC	                    | Used laptop 2015 good condition	       | 800    | JohnHarrison      | jh4142@columbia.edu | Electronics |
  | Queen size bed frame		    | Metal Platform Bed Frame with Headboard  | 120    | JohnHarrison      | jh4142@columbia.edu | Bedding |
  | Chemical Engineering Textbooks  | Textbooks for freshman to senior year	   | 10     | MikeMckenzie      | jh4142@columbia.edu | Education |
  | Air Purifier		            | Brand new. Morningside campus only       | 15     | ShuyuWang         | sw4231@columbia.edu | Electronics |
  | Desk Lamp			            | 3 brightness levels, light bulb included | 25     | JenniferLee       | jl4152@columbia.edu |Electronics |

Scenario: Unable to go to the poster page because log out
    When I go to the poster page
    Then I follow "Log out"
    Then I go to the poster page
    Then I should be on the signin page

Scenario: Create a post and delete it
  Then I should be on the post page
  Then I follow "My posts"
  Then I should see "Add Post"
  Then I follow "Add Post"
  Then I should see "Create New Post"
  Then I fill in "item" with "Airplane Drone"
  Then I fill in "description" with "used 2015"
  Then I check "buy_it_now"
  Then I fill in "start_prices" with "100"
  Then I check "auction"
  Then I fill in "start_bidding" with "50"
  Then I press "Create"
  Then I should see "Airplane Drone"
  Then I should see "delete"
  Then I follow "delete"

Scenario: Create a post with buy it now and auction
  Then I should be on the post page
  Then I follow "My posts"
  Then I should see "Add Post"
  Then I follow "Add Post"
  Then I should see "Create New Post"
  Then I fill in "item" with "Airplane Drone"
  Then I fill in "description" with "used 2015"
  Then I check "buy_it_now"
  Then I fill in "start_prices" with "100"
  Then I check "auction"
  Then I fill in "start_bidding" with "50"
  Then I press "Create"
  Then I should see "Airplane Drone"
  Then I should see "Edit"
  Then I follow "Edit"
  Then I should see "Edit Post"
  Then I fill in "item" with "Airplane Drone"
  Then I fill in "description" with "used 2015"
  Then I fill in "price" with "100"
  Then I fill in "bidding" with "60"
  Then I press "Submit"
  Then I should see "Airplane Drone"

Scenario: Create a post with buy it now and auction
    Then I should be on the post page
    Then I follow "My posts"
    Then I should see "Add Post"
    Then I follow "Add Post"
    Then I should see "Create New Post"
    Then I fill in "item" with "One plus 8t phone"
    Then I fill in "description" with "used 2021"
    Then I check "auction"
    Then I fill in "start_bidding" with "550"
    Then I press "Create"
    Then I should see "One plus 8t phone"
    Then I should see "Edit"
    Then I follow "Edit"
    Then I should see "Edit Post"
    Then I fill in "item" with "One plus 8t phone"
    Then I fill in "description" with "used 2015"
    Then I fill in "price" with "100"
    Then I fill in "bidding" with ""
    Then I press "Submit"
    Then I should see "One plus 8t phone"

Scenario: Create a post with only buy it now
    Then I should be on the post page
    Then I follow "My posts"
    Then I should see "Add Post"
    Then I follow "Add Post"
    Then I should see "Create New Post"
    Then I fill in "item" with "IPHONE CHARGER"
    Then I fill in "description" with "used 2015"
    Then I check "buy_it_now"
    Then I fill in "start_prices" with "200"
    Then I press "Create"
    Then I should see "IPHONE CHARGER"

Scenario: Create a post with only bid and update the bid
        Then I should be on the post page
        Then I follow "My posts"
        Then I should see "Add Post"
        Then I follow "Add Post"
        Then I should see "Create New Post"
        Then I fill in "item" with "SAMSUNG CHARGER"
        Then I fill in "description" with "used 2019"
        Then I check "buy_it_now"
        Then I fill in "start_prices" with ""
        Then I check "auction"
        Then I fill in "start_bidding" with "100"
        Then I press "Create"
        Then I should see "SAMSUNG CHARGER"
        Then I should see "Edit"
        Then I follow "Edit"
        Then I should see "Edit Post"
        Then I fill in "item" with "SAMSUNG CHARGER ORIGINAL"
        Then I fill in "description" with "unused"
        Then I fill in "price" with ""
        Then I fill in "bidding" with "500"
        Then I press "Submit"
        Then I should see "SAMSUNG CHARGER ORIGINAL was successfully updated."

Scenario: Create a post with only buy it now and auction and return invalid to update
        Then I should be on the post page
        Then I follow "My posts"
        Then I should see "Add Post"
        Then I follow "Add Post"
        Then I should see "Create New Post"
        Then I fill in "item" with "IPHONE CHARGER"
        Then I fill in "description" with "used 2015"
        Then I check "buy_it_now"
        Then I fill in "start_prices" with "200"
        Then I check "auction"
        Then I fill in "start_bidding" with "50"
        Then I press "Create"
        Then I should see "IPHONE CHARGER"
        Then I follow "Log out"
        Then I should be on the signin page
        Then I go to the signup page
        Then I should see "Registration"
        Then I fill in "email" with "mh4142@columbia.edu"
        Then I fill in "fname" with "Man Huang"
        Then I fill in "lname" with "Ho"
        Then I fill in "password" with "123456"
        Then I fill in "password_confirmation" with "123456"
        And  I press "Register"
        Then I should be on the post page
        When I fill in "keyword" with "IPHONE CHARGER"
        And I press "Refresh"
        Then I should see "IPHONE CHARGER"
        When I follow "See details"
        Then I should see "123@columbia.edu"
        Then I should not see "View Bid History "
        Then I should not see "Lenovo PC"
        When I fill in "amount" with "106"
        And I press "Place a bid"
        Then I should see "You placed a bid of $106"
        Then I follow "Log out"
        Then I should be on the signin page
        Then I should see "Log in"
        Then I fill in "email" with "123@columbia.edu"
        Then I fill in "password" with "123"
        And  I press "Sign in"
        Then I should be on the post page
        Then I follow "My posts"
        Then I should see "Add Post"
        Then I should see "Edit"
        Then I follow "Edit"
        Then I should see "Edit Post"
        Then I fill in "item" with "SAMSUNG CHARGER"
        Then I fill in "description" with "used 2015"
        Then I fill in "price" with "1000"
        Then I fill in "bidding" with "500"
        Then I press "Submit"
        Then I should see "You are not allowed to change the start bid when someone bid already. You can delete this post and re-post it again."
