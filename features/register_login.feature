Feature: Login and Register

  Here it shows the step of login
  and register an account
  When I attach the file "app/assets/images/F22.png" to "user_image"
  Then I should see the image "F22.png"
Background: users in database

  Given the following users exist:
  | email            | password | fname  | lname     |
  | 123@columbia.edu | 123      | John   | Ho        |
  | anabel@barnard.edu  | 12345     | Anabel   | Ho        |

Scenario: Register a new account
    Given I am on the signup page
    Then I should see "Registration"
    Then I fill in "email" with "mh4142@columbia.edu"
    Then I fill in "fname" with "Man Huang"
    Then I fill in "lname" with "Ho"
    Then I fill in "password" with "123456"
    Then I fill in "password_confirmation" with "123456"
    And  I press "Register"
    Then I should be on the post page
    Then I should see "Welcome Man Huang Ho"

Scenario: Login to existing account and then sign in to another account
  When I go to the signin page
  Then I should see "Log in"
  Then I fill in "email" with "123@columbia.edu"
  Then I fill in "password" with "123"
  And  I press "Sign in"
  Then I should be on the post page
  Then I should see "Welcome John Ho"
  And  I follow "Log out"
  Then I should be on the signin page
  When I go to the post page
  Then I should be on the signin page
  Then I fill in "email" with "anabel@barnard.edu"
  Then I fill in "password" with "12345"
  And  I press "Sign in"
  Then I should be on the post page
  Then I should see "Welcome Anabel Ho"

Scenario: Register with a existing account and flash an error
  Given I am on the signup page
  Then I should see "Registration"
  Then I fill in "email" with "123@columbia.edu"
  Then I fill in "fname" with "Mario"
  Then I fill in "lname" with "Ho"
  Then I fill in "password" with "123456"
  Then I fill in "password_confirmation" with "123456"
  And  I press "Register"
  Then I should see "Email already exist!"

Scenario: Register with a non Columbia or Barnard email and flash an error
    Given I am on the signup page
    Then I should see "Registration"
    Then I fill in "email" with "hello@gmail.com"
    Then I fill in "fname" with "Hello"
    Then I fill in "lname" with "Ho"
    Then I fill in "password" with "123456fefe"
    Then I fill in "password_confirmation" with "123456fefe"
    And  I press "Register"
    Then I should see "Please use Columbia or Barnard Email to register!"

Scenario: Register with a wrong password and flash an error
        Given I am on the signup page
        Then I fill in "email" with "mario@columbia.edu"
        Then I fill in "fname" with "Hello"
        Then I fill in "lname" with "Ho"
        Then I fill in "password" with "123456fefe"
        Then I fill in "password_confirmation" with "123456"
        And  I press "Register"
        Then I should see "Password does not match!"

Scenario: Register with a empty first name or last name and flash an error
        Given I am on the signup page
        Then I fill in "email" with "mario@columbia.edu"
        Then I fill in "fname" with ""
        Then I fill in "lname" with ""
        Then I fill in "password" with "123456"
        Then I fill in "password_confirmation" with "123456"
        And  I press "Register"
        Then I should see "Fields cannot be empty!"

Scenario: Register with a empty password and flash an error
        Given I am on the signup page
        Then I fill in "email" with "mario@columbia.edu"
        Then I fill in "fname" with "hello"
        Then I fill in "lname" with "go"
        Then I fill in "password" with ""
        Then I fill in "password_confirmation" with ""
        And  I press "Register"
        Then I should see "Password cannot be empty!"

Scenario: Signin with a wrong password and flash an error
        Given I am on the signin page
        Then I should see "Log in"
        Then I fill in "email" with "123@columbia.edu"
        Then I fill in "password" with "123456"
        And  I press "Sign in"
        Then I should see "Invalid credentials!"

Scenario: Signin with a wrong account and flash an error
        Given I am on the signin page
        Then I should see "Log in"
        Then I fill in "email" with "12345@columbia.edu"
        Then I fill in "password" with "123"
        And  I press "Sign in"
        Then I should see "Account does not exist!"

Scenario: Signin with an empty email and flash an error
        Given I am on the signin page
        Then I should see "Log in"
        Then I fill in "email" with ""
        Then I fill in "password" with "123"
        And  I press "Sign in"
        Then I should see "Email cannot be empty!"

Scenario: Signin with an empty password and flash an error
                Given I am on the signin page
                Then I should see "Log in"
                Then I fill in "email" with "123@columbia.edu"
                Then I fill in "password" with ""
                And  I press "Sign in"
                Then I should see "Password cannot be empty!"
