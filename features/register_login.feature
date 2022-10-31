Feature: Login and Register

  Here it shows the step of login
  and register an account

Background: users in database

  Given the following users exist:
  | email            | password | fname  | lname     |
  | 123@columbia.edu | 123      | John   | Ho        |

Scenario: add director to existing movie
  When I go to the signin page
  Then I should see "Log in"
  Then I fill in "email" with "123@columbia.edu"
  Then I fill in "password" with "123"
  And  I press "Submit"
  Then I should see "Welcome John Ho"
