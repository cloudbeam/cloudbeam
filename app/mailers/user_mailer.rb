class UserMailer < ApplicationMailer
  default from: 'Team Cloud-Beam <teamcloudbeam@cloud-beam.com>'
  helper ApplicationHelper

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end
end
