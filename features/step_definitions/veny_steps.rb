Given /^Logged in$/ do
  #pending "I cannot write stub of logging in....."
  User.delete_all
  @uma = Factory.build(:user_uma)
  @uma.save!

  @umako = Factory.build(:user_umako)
  @umako.save!

  class ApplicationController
    def current_user_with_stubbing
      User.find("4d74460c96b9613783000001")
    end
    def logged_in_with_stubbing?
      true
    end
    alias_method_chain :current_user, :stubbing
    alias_method_chain :logged_in?, :stubbing
  end
end

Given /^There is no mentions$/ do
  Mention.delete_all
end

When /^I visit to the venues_url with location params$/ do
  visit "/venues?lat=35.474708&lon=139.544783"
end

When /^I visit to the mentions_url with venue_id params$/ do
  visit "/mentions/4b625e3cf964a5209a442ae3"
end

Then /^I should redirected to mentions path$/ do
  URI.parse(current_url).path.should == "/mentions/4b625e3cf964a5209a442ae3"
end

Then /^I should see active nav (.+)$/ do |text|
  page.should have_xpath(".//li[@class='active']/a", :text => text, :count => 1)
end

Then /^I should see Login link$/ do
  page.should have_xpath(".//a", :text => "Login with Facebook", :count => 1)
end

Then /^I should choose place from palace list$/ do
  page.should have_xpath(".//a[starts-with(@href, '/mentions')]")
end

Then /^I should be able to add new venue to click a link$/ do
  page.should have_xpath(".//a[@id='addNewSpot']")
end

Then /^I should be able to see "(.+)" form$/ do |form_id|
  page.should have_xpath(".//form[@id='#{form_id}']")
end

Then /^the mention should have saved$/ do
  Mention.where(:text => "test mention").size.should == 1
  page.should have_xpath(".//div[@id='mentionsArea']/div[@class='mention']", :count => 1)
end

Then /^the mention should have deleted$/ do
  Mention.where(:text => "test mention").size.should == 0
  page.should_not have_xpath(".//div[@id='mentionsArea']/div[@class='mention']")
end

Then /^I should find a create venue forms$/ do
  page.should have_xpath(".//form[@id='createVenueForm']")
  # see document
  # https://developer.foursquare.com/docs/venues/add.html
  # I don't use "primaryCategoryId" now.
  page.should have_xpath(".//input[starts-with(@name,'venue')]", :count => 8)
end

Then /^Add Venue API should be called$/ do
  pending "This case will be tested using RSpec"
end

Then /^I should redirected to the mentions_url with venue_id params$/ do
  current_path = URI.parse(current_url).path
  current_path.should = "/venues?lat=35.474708&lon=139.544783"
end
