class PasswordResetsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user
      user.send_password_reset
      flash[:notice] = "An email has been sent to #{params[:email]} with password reset instructions."
      redirect_to login_url
    else
      flash[:alert] = "We have no account associated with #{params[:email]}. Sign up to start beaming!"
      redirect_to controller: 'users', action: 'new'
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: 'Password reset link has expired.'
    end
    helpers.set_new_passwords(@user, params)
    if @user.save
      redirect_to download_url, notice: 'Password has been reset!'
    else
      render :edit
    end
  end
end
