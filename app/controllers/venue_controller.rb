class VenueController < ApplicationController
  before_filter :authenticate_user

  def new
    @ll = params[:ll]
    @ll ||= ""
    render :layout => false
  end

  def create
    if params[:venue_ll]
      ll = params[:venue_ll].split(",")
      lat = ll.first
      lon = ll.second
    end
    if lat and lon
      if params[:venue_name]
        venue = {}
        venue[:name] = params[:venue_name] if params[:venue_name]
        venue[:address] = params[:venue_address] if params[:venue_address]
        venue[:crossStreet] = params[:venue_cross_street] if params[:venue_cross_street]
        venue[:city] = params[:venue_city] if params[:venue_city]
        venue[:state] = params[:venue_state] if params[:venue_state]
        venue[:zip] = params[:venue_zip] if params[:venue_zip]
        venue[:phone] = params[:venue_phone] if params[:venue_phone]
        venue[:ll] = params[:venue_ll]
        FoursquareVenue.add_venue(venue)
      end
      redirect_to venues_url(:lat => lat, :lon => lon)
    else
      redirect_to venues_url
    end
  end
end
