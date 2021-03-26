module PasswordResetsHelper
  def set_new_passwords(user, params)
    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
  end
end
