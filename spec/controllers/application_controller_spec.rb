# coding: utf-8
require 'spec_helper'

describe ApplicationController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

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

  it "current_userがログインユーザのUserインスタンスを返す" do
    session[:user_id] = @uma.id
    controller.send(:current_user).should == @uma
  end

  it "logged_in?でログインしているかどうかを返す" do
    session[:user_id] = @uma.id
    controller.send(:logged_in?).should == true

    session[:user_id] = nil
    controller.send(:logged_in?).should == false
  end

  it "logged_inでログインしているかどうかを返す(alias)" do
    session[:user_id] = @uma.id
    controller.send(:logged_in).should == true

    session[:user_id] = nil
    controller.send(:logged_in).should == false
  end

  it "authenticate_userはログインフィルタ" do
    controller.should_receive(:logged_in?).and_return(true)
    controller.send(:authenticate_user)
  end
end
