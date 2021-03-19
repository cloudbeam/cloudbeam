class ApplicationController < ActionController::Base
  before_action :session_expires
  before_action :update_session_time

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def session_expires
    return unless session[:expires_at]

    expiration = session[:expires_at].to_time
    time_left = expiration - Time.now

    unless time_left > 0
      reset_session
      flash[:alert] = "Session expired."
      redirect_to login_url
    end
  end

  def update_session_time
    session[:expires_at] = 60.minutes.from_now if session[:expires_at]
  end
end
