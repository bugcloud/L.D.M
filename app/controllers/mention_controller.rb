class MentionController < ApplicationController
  before_filter :authenticate_user

  def mentions
    if params[:venue_id]
      @mentions = Mention.find_by_venue_id(params[:venue_id])
    end
    @mentions ||= []

    @mention = Mention.new(:venue_id => params[:venue_id])
  end

  def create
    m = Mention.new(params[:mention])
    m.user = current_user
    m.save!
    redirect_to mentions_path(:venue_id => params[:venue_id])
  end

  def destroy
    m = Mention.find(params[:id])
    vid = m.venue_id
    if m.user == current_user
      m.destroy
    end
    redirect_to mentions_path(:venue_id => vid)
  end
end
