class DistributedPreview < ActionMailer::Preview
  def distributed
    DocumentMailer.with(user: User.first).distributed
  end
end
# http://localhost:3000/rails/mailers/notifier/welcome
