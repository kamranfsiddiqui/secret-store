Feature: Add/deleta Secrets 
  As a user of Secret Store
  I want to add and delete secrets
  So that I can view it later

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

Scenario: Add new secret happy path
  Given I am on the log in page
  When I fill in the following:
    | Email                 | msnow@cia.com |
    | Password              | marksnow      |   
  And I press "Log in"
  And I press "Add New Secret!"
  When I fill in the following:
    | Title          | My Crush                  |   
    | Description    | I have a crush on Martha. |
  And I follow "Save edits"
	Then I should see "New Secret added successfully"
  And I follow "Logout" 

Scenario: Add new secret sad path
  Given I am on the log in page
  When I fill in the following:
    | Email                 | msnow@cia.com |
    | Password              | marksnow      |   
  And I press "Log in"
  And I press "Add New Secret!"
  And I submit the form
  Then I should see "There was an error in adding the secret. Please try again."
  Then I am on the user home page
  And I follow "Logout" 

Scenario: Delete a secret
  Given I am on the log in page
  When I fill in the following:
    | Email                 | msnow@cia.com |
    | Password              | marksnow      |   
  And I press "Log in"
  And I press "Add New Secret!"
  When I fill in the following:
    | Title          | My Crush                  |   
    | Description    | I have a crush on Martha. |
  And I press "Save edits"
	Then I should see "New Secret added successfully"
  When I follow "Delete Secret"
  And I confirm popup
	Then I should see "The secret was successfully destroyyed"



	


