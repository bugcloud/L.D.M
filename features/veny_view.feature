Feature: user access to Veny

  As a user
  I want to see site
  So that I can access to this site

  Scenario: access to top page at first time
    When I go to the homepage
    Then I should see "Veny"
    And I should see Login link 

  Scenario: access to top page after logged in
    Given Logged in
    When I go to the homepage
    Then I should see "Veny"
    And I should see "here is..." 
    And I should see active nav Home

  Scenario: access to venues page
    Given Logged in
    When I go to the venues page
    Then I should see active nav Venues

  Scenario: access to venues page with location parameters
    Given Logged in
    When I visit to the venues_url with location params
    Then I should see active nav Venues
    And I should choose place from palace list
    And I should be able to add new venue to click a link

  Scenario: access to mentions page
    Given Logged in
    When I visit to the mentions_url with venue_id params
    Then I should be able to see "new_mention" form

  Scenario: create mention
    Given Logged in
    And There is no mentions
    When I visit to the mentions_url with venue_id params
    And I fill in "mention_text" with "test mention"
    And I press "mention_submit"
    Then I should redirected to mentions path
    And the mention should have saved

  Scenario: delete mention
    Given Logged in
    And There is no mentions
    When I visit to the mentions_url with venue_id params
    And I fill in "mention_text" with "test mention"
    And I press "mention_submit"
    And I follow "delete"
    Then I should redirected to mentions path
    And the mention should have deleted

  @javascript
  Scenario: add new venue(show form)
    Given Logged in
    When I visit to the venues_url with location params
    And I follow "[+] Add new spot"
    Then I should find a create venue forms

  @javascript
  Scenario: add new venue(submit form)
    Given Logged in
    When I visit to the venues_url with location params
    And I follow "[+] Add new spot"
    And I fill in "venue_name" with "旭区役所"
    And I fill in "venue_address" with "meguro"
    And I fill in "venue_cross_street" with "meguro St."
    And I fill in "venue_city" with "meguroku"
    And I fill in "venue_state" with "tokyo"
    And I fill in "venue_zip" with "1231234"
    And I fill in "venue_phone" with "0312341234"
    And I press "Add"
    Then Add Venue API should be called
    Then I should redirected to the mentions_url with venue_id params
