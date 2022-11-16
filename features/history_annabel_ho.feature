# Project Iteration 2

Feature: User history of Anabel Ho

  Here it shows how our users can check their sell and order history

Background: users in database
  Given the following users exist:
  | email            | password | fname  | lname     |
  | jh4142@columbia.edu | 123      | John   | Harrison        |
  | anabel@barnard.edu  | 12345     | Anabel   | Ho        |

  When I go to the signin page
  Then I should see "Log in"
  Then I fill in "email" with "anabel@barnard.edu"
  Then I fill in "password" with "12345"
  And  I press "Sign in"
  Then I should be on the post page

  Given the following bids exist:
  | product_id | user_id | bid |
  | 2 | 1 | 105 |

  Given the following order histories exist:
  | product_id | buyer_id | price |
  | 1 | 2 | 800 |

  Given the following posts exist:
  | item                            | description                              | price  | user              | email               | category | buy_now | bid | start_bid | current_bid | closed |
  | Laptop MAC	                    | Used laptop 2015 good condition	       | 800    | JohnHarrison      | jh4142@columbia.edu | Electronics | true | false |   |   | true |
  | Queen size bed frame		    | Metal Platform Bed Frame with Headboard  | 120    | JohnHarrison      | jh4122@columbia.edu | Bedding | true | true |  100 | 105  | false |
  | Chemical Engineering Textbooks  | Textbooks for freshman to senior year	   | 10     | MikeMckenzie      | jh4141@columbia.edu | Education | false | true  | 5   | 5  | false |
  | Air Purifier		            | Brand new. Morningside campus only       | 15     | ShuyuWang         | sw4231@columbia.edu | Electronics |  false | true  | 10   | 10  | false |
  | Desk Lamp			            | 3 brightness levels, light bulb included | 25     | JenniferLee       | jl4152@columbia.edu |Electronics |  true | true  | 15   | 15  | false |

Scenario: See the order history
        When I follow "Order history"
        Then I should not see "Desk Lamp"
        Then I should see "Laptop MAC"
        Then I should see "Item id"
        Then I should see "Deal Price"
        Then I should see "Seller"
        Then I should see "Time"
        And I follow "Back to Post list"
        Then I should be on the post page

Scenario: Go to selling history page without logging:
        When I follow "Log out"
        When I go to the order history page
        Then I should be on the signin page

Scenario: Go to order history page without logging:
        When I follow "Log out"
        When I go to the selling history page
        Then I should be on the signin page

