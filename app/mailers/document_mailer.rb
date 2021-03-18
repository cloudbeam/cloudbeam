class DocumentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.file_entity_mailer.distributed.subject
  #
  default from: "Team Cloud-Beam <teamcloudbeam@cloud-beam.com>"
  def distributed(sender, recipient_email, document, message, download_code)
    @message = message
    @download_code = download_code
    @document = document

<<<<<<< HEAD
    @sender = sender

    mail to: recipient_email, subject: "#{sender.first_name} #{sender.last_name} has shared a file: #{document.name}!"
  end

=======
    mail to: recipient_email, subject: "#{sender.first_name} #{sender.last_name} has shared a file: #{document.name}!"
  end

>>>>>>> 101132faa9f604c40737ac810f9981f06aace65d
  def sender_distributed(email, document, recipient_emails, message)
    @document = document
    @recipient_emails = recipient_emails
    @message = message

    mail to: email, subject: "You shared the file #{document.name} with #{recipient_emails.count} people"
  end
end
