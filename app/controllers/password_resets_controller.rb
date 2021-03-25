class PasswordResetsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to download_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    end
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      redirect_to download_url, notice: 'Password has been reset.'
    else
      render :edit
    end
  end
end
