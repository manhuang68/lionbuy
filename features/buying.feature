# Project Iteration 2

Feature: Buying a product

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

  Given the following order histories exist:
  | product_id | buyer_id | price |
  | 1 | 2 | 800 |

  Given the following posts exist:
  | item                            | description                              | price  | user              | email               | category | buy_now | bid | start_bid | current_bid | closed |
  | keyboard                        | used                                     | 800    | JohnHarrison      | jh4142@columbia.edu |  Electronics | true | false |   |   | true |
  | Lenovo PC                  | Used laptop 2015 good condition	       | 800    | JohnHarrison      | jh4142@columbia.edu | Electronics | true | false |   |   | false |
  | Panasonic TV		    | GOOD CONDITION  | 120    | JohnHarrison      | jh4142@columbia.edu | Bedding | true | true |  100 | 105  | false |
  | INTRO TO CS | Textbooks for freshman to senior year	   | 10     | MikeMckenzie      | jh4142@columbia.edu | Education | false | true  | 5   | 5  | false |
  | Air conditioner		            | Brand new. Morningside campus only       | 15     | ShuyuWang         | sw4231@columbia.edu | Electronics |  false | true  | 10   | 10  | false |
  | Monitor	            | 3 brightness levels, light bulb included | 25     | JenniferLee       | jl4152@columbia.edu |Electronics |  true | true  | 15   | 15  | false |

Scenario: See the details of a post and make a purchase
    When I fill in "keyword" with "Panasonic TV"
    And I press "Refresh"
    Then I should see "Panasonic TV"
    When I follow "See details"
    Then I should see "JohnHarrison"
    Then I should see "jh4142@columbia.edu"
    Then I should see "View Bid History "
    Then I should not see "Lenovo PC"
    And I press "Buy it now"
    Then I should see "Your order for Panasonic TV has been placed!"

Scenario: See the details of a post and make a purchase
        When I fill in "keyword" with "Monitor"
        And I press "Refresh"
        Then I should see "Monitor"
        When I follow "See details"
        Then I should see "JenniferLee"
        Then I should see "jl4152@columbia.edu"
        Then I should not see "View Bid History "
        Then I should not see "Lenovo PC"
        And I press "Buy it now"
        Then I should see "Monitor"
