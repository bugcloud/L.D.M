#coding: utf-8
require 'spec_helper'

describe :initializers do
  FOURSQUARE_API_ACCESS_TOKEN = "5IMK0Z44E5MOIKDONHIX4SNZBBX2GRYF0BOIDKG5E2HJWCUL"
  
  before(:each) do
    FoursquareVenue.class_eval{
      @foursquare_request = nil
    }
  end

  describe 'class FoursquareVenue' do
    context "get the list of venues" do
      it "should call Foursquare API 'Venue.search'" do
        fr = double('foursquare_venue')
        Foursquare::Venue.should_receive(:new).with(FOURSQUARE_API_ACCESS_TOKEN).and_return(fr)
        fr.should_receive(:search).with({:ll => "35.63453,139.713722"})

        FoursquareVenue.venue_list(35.63453,139.713722)
      end
    end

    context "add new venue" do
      it "should not call venue/add API when name is empty" do
        Foursquare::Venue.should_not_receive(:new)

        h = {:name => "", :ll => "35.63453,139.713722"}
        FoursquareVenue.add_venue(h)
        h = {:name => nil, :ll => "35.63453,139.713722"}
        FoursquareVenue.add_venue(h)
        h = {:ll => "35.63453,139.713722"}
        FoursquareVenue.add_venue(h)
      end
      
      it "should not call venue/add API when ll is empty" do
        Foursquare::Venue.should_not_receive(:new)

        h = {:name => "test", :ll => ""}
        FoursquareVenue.add_venue(h)
        h = {:name => "test", :ll => nil}
        FoursquareVenue.add_venue(h)
        h = {:name => "test"}
        FoursquareVenue.add_venue(h)
      end

      it "should not call venue/add API when ll does not have ','" do
        Foursquare::Venue.should_not_receive(:new)
        h = {:name => "test", :ll => "35.63453 139.713722"}
        FoursquareVenue.add_venue(h)
      end

      it "should call venue/add API when FoursquareVenue.add_venue was called with correct parameters" do
        fr = double('foursquare_venue')
        Foursquare::Venue.should_receive(:new).with(FOURSQUARE_API_ACCESS_TOKEN).and_return(fr)
        fr.should_receive(:add).with({:name => "旭区役所", :ll => "35.474708,139.544783"})

        h = {:name => "旭区役所", :ll => "35.474708,139.544783"}
        FoursquareVenue.add_venue(h)
      end
    end
  end
end
