class ApplicationController < ActionController::Base
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
