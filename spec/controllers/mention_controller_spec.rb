#coding: utf-8
require 'spec_helper'

describe MentionController do
  before(:all) do
    User.delete_all
    Mention.delete_all
  end

  before(:each) do
    @umao = Factory.build(:user_uma)
    @umao.save!
    @umako = Factory.build(:user_umako)
    @umako.save!
    @umazo = Factory.build(:user_umazo)
    @umazo.save!

    @m1 = Factory.build(:mention001)
    @m1.user = @umao
    @m1.save!

    @m2 = Factory.build(:mention002)
    @m2.user = @umako
    @m2.save!

    @m3 = Factory.build(:mention003)
    @m3.user = @umazo 
    @m3.save!
  end

  after(:each) do
    @m1 = nil
    @m2 = nil
    @m3 = nil
    @umao = nil
    @umako = nil
    @umazo = nil
    Mention.delete_all
    User.delete_all
  end

  context "GET 'mentions/:venue_id'" do
    it "パラメータのvenue_idでMentionを検索" do
      session[:user_id] = @umao.id

      ms = Mention.find_by_venue_id(@m1.venue_id)
      Mention.should_receive(:find_by_venue_id).with(@m1.venue_id).and_return(ms)
      
      get 'mentions', :venue_id => @m1.venue_id
      mentions = assigns[:mentions].to_a
      mentions.should include(@m1)
      mentions.should include(@m2)
      mentions.should_not include(@m3)
      response.should be_success
    end

    it "should Mention追加用のフォームを生成" do
      session[:user_id] = @umao.id
      get 'mentions', :venue_id => @m1.venue_id
      assigns[:mention].should_not == nil
      assigns[:mention].venue_id.should == @m1.venue_id
    end
  end

  context "POST 'mentions/:venue_id'" do
    it "should 対象のvenueに対してMentionを追加する" do
      session[:user_id] = @umao.id
      post 'create', :mention => {:venue_id => @m1.venue_id, :text => 'fu'}, :venue_id => @m1.venue_id
      mentions = Mention.where(:text => 'fu')
      mentions.size.should == 1
      m = mentions.first
      m.text.should == 'fu'
      m.user.should == @umao
      response.should redirect_to(mentions_path(:venue_id => @m1.venue_id))
    end
  end

  context "DELETE 'mentions/:id/delete'" do
    it "should 自分のMentionを消せる" do
      session[:user_id] = @umao.id
      delete 'destroy', :id => @m1.id.to_s
      Mention.where(:text => @m1.text).size.should == 0
      response.should redirect_to(mentions_path(:venue_id => @m1.venue_id))
    end

    it "should 人のMentionは消せない" do
      session[:user_id] = @umako.id
      delete 'destroy', :id => @m1.id.to_s
      Mention.where(:text => @m1.text).size.should > 0
      response.should redirect_to(mentions_path(:venue_id => @m1.venue_id))
    end
  end
end
