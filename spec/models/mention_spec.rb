#coding: utf-8
require 'spec_helper'

describe Mention do
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

  context "validation" do
    it "should venue_id, textは必須" do
      error = Factory.build(:error_mention001)
      error.should have(1).errors_on(:venue_id)
      error.should have(1).errors_on(:text)

      error2 = Factory.build(:error_mention002)
      error2.should have(1).errors_on(:venue_id)
      error2.should have(1).errors_on(:text)
    end
  end

  context "relationship" do
    it "Mention belongs_to User" do
      m1 = Mention.find(@m1.id)
      m1.user.should == @umao

      m2 = Mention.find(@m2.id)
      m2.user.should == @umako

      m3 = Mention.find(@m3.id)
      m3.user.should == @umazo
    end
  end

  context "scope" do
    it "should Mention.find_by_venue_idでvenue_idで絞り込んでcreated_atの降順で取得" do
      mentions = Mention.find_by_venue_id(@m1.venue_id)
      mentions.size.should == 2
      mentions.first.should == @m2
      mentions.second.should == @m1
    end
  end
end
