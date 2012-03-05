class TopController < ApplicationController
  before_filter :authenticate_user, :except => :welcome
  def index
  end

  def venues
    @venues = FoursquareVenue.venue_list(params[:lat], params[:lon])
    @ll = "#{params[:lat]},#{params[:lon]}"
    unless @venues['response'] and @venues['response']['groups']
      @venues = nil
    end
  end

  def welcome
    render :layout => 'clean'
  end
end
