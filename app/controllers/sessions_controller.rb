class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    if session[:user_id] then
      redirect_to documents_dashboard_url
    end
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.try(:authenticate, params[:user][:password]) then
      session[:user_id] = user.id
      cookies.signed[:user_id] = user.id
      redirect_to documents_dashboard_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    if session[:user_id] then
      session[:user_id] = nil
      cookies.delete(:user_id)
      redirect_to login_url, notice: "Logged out"
    else 
      redirect_to download_url
    end
  end
end
