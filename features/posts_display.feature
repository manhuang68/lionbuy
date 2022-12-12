# Project Iteration 1

Feature: Post Display

  Here it shows how our users can find posts they like
  by either categorizing, searcing, or filtering

Background: users in database
  Given that I clean up the post table
  Given that I clean up the bid table
  Given that I clean up the user table
  Given that I clean up the history table

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

Scenario: restrict to movies with "Electronics" or "Education" categories
    Given I uncheck the following categories: Bedding
    And I check the following categories: Electronics, Education
    When I press "Refresh"
    Then I should see "Chemical Engineering Textbooks"
    Then I should see "Air Purifier"
    Then I should see "Laptop MAC"
    Then I should see "Desk Lamp"
    Then I should not see "Queen size bed frame"

Scenario: all categories selected
    Given I check the following categories: Electronics, Education, Bedding
    When I press "Refresh"
    Then I should see all the posts

Scenario: search with empty keyword
    When I fill in "keyword" with ""
    And I press "Refresh"
    Then I should see all the posts

Scenario: search with keyword "MAC"
    When I fill in "keyword" with "MAC"
    And I press "Refresh"
    Then I should see "Laptop MAC"
    Then I should not see "Queen size bed frame"

Scenario: set price range between 20 and 100
    When I fill in "min_price" with "20"
    When I fill in "max_price" with "100"
    And I press "Refresh"
    Then I should see "Desk Lamp"
    Then I should not see "Laptop MAC"
    Then I should not see "Queen size bed frame"

Scenario: set MIN price range as 200 only
    When I fill in "min_price" with "200"
    And I press "Refresh"
    Then I should see "Laptop MAC"
    Then I should not see "Desk Lamp"
    Then I should not see "Queen size bed frame"

Scenario: set MAX price range as 100 only
    When I fill in "max_price" with "50"
    And I press "Refresh"
    Then I should not see "Laptop MAC"
    Then I should see "Desk Lamp"
    Then I should see "Chemical Engineering Textbooks"
    Then I should see "Air Purifier"

Scenario: set price range as invalid strings
    When I fill in "max_price" with "hello"
    And I press "Refresh"
    Then I should see "Invalid price range"

Scenario: set price range as invalid strings
    When I fill in "max_price" with "100"
    And I fill in "min_price" with "200"
    And I press "Refresh"
    Then I should see "Invalid price range"

Scenario: combination of categorizing, searcing, and filtering
    Given I uncheck the following categories: Bedding, Education
    And I check the following categories: Electronics
    And I fill in "min_price" with "20"
    And I fill in "max_price" with "1000"
    And I fill in "keyword" with "MAC"
    And I press "Refresh"
    Then I should not see "Chemical Engineering Textbooks"
    Then I should not see "Air Purifier"
    Then I should not see "Queen size bed frame"
    Then I should not see "Desk Lamp"
    Then I should see "Laptop MAC"
