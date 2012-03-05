class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :logged_in?
  helper_method :logged_in

  protected
  def authenticate_user
    unless logged_in?
      redirect_to welcome_url
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def logged_in
    logged_in?
  end
end
