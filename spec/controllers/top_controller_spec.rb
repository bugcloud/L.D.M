#coding: utf-8
require 'spec_helper'

describe TopController do

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

  describe "GET 'index'" do
    it "ログインしてなければ/welcomeにリダイレクト" do
      get 'index'
      response.should redirect_to :action => 'welcome'
    end

    it "should be successful" do
      #login
      controller.stub!(:current_user).and_return(@uma)
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'venues'" do
    it "ログインしてなければ/welcomeにリダイレクト" do
      get 'index'
      response.should redirect_to :action => 'welcome'
    end

    it "should be successful" do
      e = {"meta"=>{"code"=>200, "errorType"=>"deprecated", "errorDetail"=>"This endpoint will stop returning groups in the future. Please use a current version, see http://bit.ly/lZx3NU."}, "notifications"=>[{"type"=>"notificationTray", "item"=>{"unreadCount"=>0}}], "response"=>{"groups"=>[{"type"=>"nearby", "name"=>"Nearby", "items"=> ['a','b']}]}}
      FoursquareVenue.should_receive(:venue_list).with("35.63453","139.713722").and_return(e)

      #login
      controller.stub!(:current_user).and_return(@uma)
      get 'venues', :lat => "35.63453", :lon => "139.713722"
      assigns[:venues].should == e
      response.should be_success
    end

    it "should itemsが取得できないときは@venuesをnilに設定" do
      e = {"meta"=>{"code"=>200, "errorType"=>"deprecated", "errorDetail"=>"This endpoint will stop returning groups in the future. Please use a current version, see http://bit.ly/lZx3NU."}, "notifications"=>[{"type"=>"notificationTray", "item"=>{"unreadCount"=>0}}], "response"=>{}}
      FoursquareVenue.should_receive(:venue_list).with("35.63453","139.713722").and_return(e)

      #login
      controller.stub!(:current_user).and_return(@uma)
      get 'venues', :lat => "35.63453", :lon => "139.713722"
      assigns[:venues].should be_false#nil
      assigns[:ll].should == "35.63453,139.713722"
      response.should be_success
    end
  end
end
