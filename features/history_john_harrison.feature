# Project Iteration 2

Feature: User history of John Harrison

  Here it shows how our users can check their sell and order history

Background: users in database
  Given that I clean up the post table
  Given that I clean up the bid table
  Given that I clean up the user table
  Given that I clean up the history table

  Given the following users exist:
  | email            | password | fname  | lname     |
  | jh4142@columbia.edu | 123      | John   | Harrison        |
  | anabel@barnard.edu  | 12345     | Anabel   | Ho        |

  When I go to the signin page
  Then I should see "Log in"
  Then I fill in "email" with "jh4142@columbia.edu"
  Then I fill in "password" with "123"
  And  I press "Sign in"
  Then I should be on the post page

  Given the following posts exist:
  | item                            | description                              | price  | user              | email               | category | buy_now | bid | start_bid | current_bid | closed |
  | Laptop MAC	                    | Used laptop 2015 good condition	       | 800    | JohnHarrison      | jh4142@columbia.edu | Electronics | true | false |   |   | true |
  | Queen size bed frame		    | Metal Platform Bed Frame with Headboard  | 120    | JohnHarrison      | jh4122@columbia.edu | Bedding | true | true |  100 | 105  | false |
  | Chemical Engineering Textbooks  | Textbooks for freshman to senior year	   | 10     | MikeMckenzie      | jh4141@columbia.edu | Education | false | true  | 5   | 5  | false |
  | Air Purifier		            | Brand new. Morningside campus only       | 15     | ShuyuWang         | sw4231@columbia.edu | Electronics |  false | true  | 10   | 10  | false |
  | Desk Lamp			            | 3 brightness levels, light bulb included | 25     | JenniferLee       | jl4152@columbia.edu |Electronics |  true | true  | 15   | 15  | false |

  Given that I insert the following data to history table product name "Laptop MAC" , buyer "anabel@barnard.edu" , price "800"

Scenario: See the sell history
        When I follow "Selling summary"
        Then I should see "Buyer"
        Then I should see "AnabelHo"
        Then I should see "Deal Price"
        Then I should see "800"
        Then I should see "Laptop MAC"
        Then I should not see "Desk Lamp"
        And I follow "Back to Post list"
        Then I should be on the post page

Scenario: See the order history
        When I follow "Order history"
        Then I should not see "Desk Lamp"
        Then I should see "Item id"
        Then I should see "Deal Price"
        Then I should see "Seller"
        Then I should see "Time"
        And I follow "Back to Post list"
        Then I should be on the post page


