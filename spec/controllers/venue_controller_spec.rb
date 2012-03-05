#coding: utf-8
require 'spec_helper'

describe VenueController do
  before(:all) do
   User.delete_all
  end 

  before(:each) do
    @uma = Factory.build(:user_uma)
    @uma.save!

    @umako = Factory.build(:user_umako)
    @umako.save!
  end

  after(:each) do
    User.delete_all
    @uma = nil
    @umako = nil
  end

  describe "GET 'new'" do
    it "ログインしてなければ/welcomeにリダイレクト" do
      get 'new'
      response.should redirect_to :controller => 'top', :action => 'welcome'
    end

    it "should be successful" do
      #login
      controller.stub!(:current_user).and_return(@uma)
      get 'new', :ll => "35.689927,139.69172"
      assigns[:ll].should == "35.689927,139.69172"
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "ログインしてなければ/welcomeにリダイレクト" do
      post 'create'
      response.should redirect_to :controller => 'top', :action => 'welcome'
    end

    it "should be successful" do
      #login
      controller.stub!(:current_user).and_return(@uma)
      FoursquareVenue.should_receive(:add_venue).with({:ll => "35.474708,139.544783", :name => "旭区役所"})
      post 'create', :venue_ll => "35.474708,139.544783", :venue_name => "旭区役所"
      response.should redirect_to :controller => 'top', :action => 'venues', :lat => '35.474708', :lon => '139.544783'
    end
  end
end
