module Foursquare
  CONFIG = YAML.load_file(Rails.root.join("config/foursquare.yml"))
  FOURSQUARE_API_ACCESS_TOKEN = CONFIG['oauth']['access_token']
end

require 'foursquare'

class FoursquareVenue
  def initialize
    @foursquare_request = Foursquare::Venue.new(Foursquare::FOURSQUARE_API_ACCESS_TOKEN.to_s)
  end

  def self.venue_list(lat = 35.689927, lon = 139.69172)
    @foursquare_request = Foursquare::Venue.new(Foursquare::FOURSQUARE_API_ACCESS_TOKEN.to_s) if @foursquare_request.nil?
    @foursquare_request.search(:ll => "#{lat.to_s},#{lon.to_s}")
  end

  def self.add_venue(venue)
    if venue.class == Hash and venue.has_key?(:name) and venue.has_key?(:ll)
      if !venue[:name].nil? and venue[:name] != "" and !venue[:ll].nil? and venue[:ll] != "" and venue[:ll].count(",") > 0
        @foursquare_request = Foursquare::Venue.new(Foursquare::FOURSQUARE_API_ACCESS_TOKEN.to_s) if @foursquare_request.nil?
        @foursquare_request.add(venue)
      end
    end
  end
end
