class SessionsController < ApplicationController
  def create
    begin
      access_token = Koala::Facebook::OAuth.new(login_url).get_access_token(params[:code]) if params[:code]
      rest = Koala::Facebook::GraphAndRestAPI.new(access_token)
      me = rest.get_object("me")

      user = User.where(:facebook_id => me["id"].to_s)
      if user.empty?
        user = User.new(
          :username => me["first_name"] + "." + me["last_name"],
          :facebook_id => me["id"].to_s,
          :access_token => access_token,
          :facebook => me
        )
      else
        user = user.first
        user.facebook = me
      end

      if user.save
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Signed in!!"
      else
        redirect_to root_url, :error => "Some error has occurred..."
      end
    rescue Exception
      puts "#$!"
      render :file => "#{::Rails.root.to_s}/public/500.html", :layout => false, :status => 500
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => "Signed out!!"
  end

end
