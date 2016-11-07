Feature: User Sign In
  
  As a user of Secret Store 
  I want to login to 
  So that I can securely access my secrets

Background:
  Given I am on the user sign up page
  When I fill in the following:
    | Username              | MarkSnow      |   
    | Email                 | msnow@cia.com |
    | Password              | marksnow      |   
    | Password confirmation | marksnow      |   
  And I press "Sign up" 
  And I press "My Secrets" 
  And I follow "Logout" 
  
Scenario: Sign In
  When I go to the log in page
  Then I should see "Remember me"
  And I fill in the following:
    |Email     |msnow@cia.com |
    |Password  |marksnow      |
  And I press "Log in" 
  Then I should see "Signed in successfully"
  And I should be on the secrets page for "msnow@cia.com"
  And I follow "Logout" 

Scenario: Sign in Sad Path
  When I go to the log in page
  And I fill in "Email" with "carson@ucsf.org"
  And I fill in "Password" with "carson"
  And I press "Log in" 
  Then I should see "Invalid email or password"
  
Scenario: Log out 
  When I go to the log in page
  And I fill in the following:
    |Email     |msnow@cia.com |
    |Password  |marksnow      |
  And I press "Log in" 
  Then I should see "Logout"
  When I follow "Logout"
  Then I should see "Signed out successfully"
  
