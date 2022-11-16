# Project Iteration 2

Feature: Price Bidding

  Here it shows how our users can bid on active items

Background: users in database
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

  Given the following bids exist:
  | product_id | user_id | bid |
  | 2 | 1 | 105 |

  Given the following posts exist:
  | item                            | description                              | price  | user              | email               | category | buy_now | bid | start_bid | current_bid |
  | Laptop MAC	                    | Used laptop 2015 good condition	       | 800    | JohnHarrison      | jh4142@columbia.edu | Electronics | true | false |   |   |
  | Queen size bed frame		    | Metal Platform Bed Frame with Headboard  | 120    | JohnHarrison      | jh4142@columbia.edu | Bedding | true | true |  100 | 105  |
  | Chemical Engineering Textbooks  | Textbooks for freshman to senior year	   | 10     | MikeMckenzie      | jh4142@columbia.edu | Education | false | true  | 5   | 5  |
  | Air Purifier		            | Brand new. Morningside campus only       | 15     | ShuyuWang         | sw4231@columbia.edu | Electronics |  false | true  | 10   | 10  |
  | Desk Lamp			            | 3 brightness levels, light bulb included | 25     | JenniferLee       | jl4152@columbia.edu |Electronics |  true | true  | 15   | 15  |

Scenario: See the details of a post and make a bid to an existing bid
    When I fill in "keyword" with "Queen size bed frame"
    And I press "Refresh"
    Then I should see "Queen size bed frame"
    When I follow "See details"
    Then I should see "JohnHarrison"
    Then I should see "jh4142@columbia.edu"
    Then I should see "View Bid History "
    Then I should not see "Laptop MAC"
    When I fill in "amount" with "106"
    And I press "Place a bid"
    Then I should see "You placed a bid of $106"

Scenario: See the details of a post and make a first time invalid bid to a post
        When I fill in "keyword" with "Air Purifier"
        And I press "Refresh"
        Then I should see "Air Purifier"
        When I follow "See details"
        Then I should see "ShuyuWang"
        Then I should not see "View Bid History "
        When I fill in "amount" with "9"
        And I press "Place a bid"
        Then I should see "The Bid amount must be equal or greater than $10"

Scenario: See the details of a post and make a first time bid on a post and see the history of bidding
        When I fill in "keyword" with "Air Purifier"
        And I press "Refresh"
        Then I should see "Air Purifier"
        When I follow "See details"
        Then I should see "ShuyuWang"
        Then I should not see "View Bid History"
        Then I should not see "Laptop MAC"
        When I fill in "amount" with "10"
        And I press "Place a bid"
        Then I should see "You placed a bid of $10"
        Then I follow "View Bid History"
        Then I should see "You're the highest bidder!"

Scenario: See the details of a post and make a invalid bid to an existing bid
        When I fill in "keyword" with "Queen size bed frame"
        And I press "Refresh"
        Then I should see "Queen size bed frame"
        When I follow "See details"
        Then I should see "JohnHarrison"
        Then I should see "jh4142@columbia.edu"
        Then I should see "View Bid History "
        Then I should not see "Laptop MAC"
        When I fill in "amount" with "100"
        And I press "Place a bid"
        Then I should see "The Bid amount must be greater than $105"

Scenario: Go to a detail post without logging:
        When I follow "Log out"
        When I go to the details page for "Desk Lamp"
        Then I should be on the signin page
