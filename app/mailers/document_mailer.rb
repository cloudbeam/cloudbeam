class DocumentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  # en.file_entity_mailer.distributed.subject
  #
  default from: "Team Cloud-Beam <teamcloudbeam@cloud-beam.com>"
  def distributed(sender, recipient_email, document, message, download_code)
    @sender = sender
    @message = message
    @download_code = download_code
    @document = document
    @sender = sender
    @expiration = document[:uploaded_at] + 30.days

    mail to: recipient_email, subject: "#{sender.first_name} #{sender.last_name} has shared a file: #{document.name}!"
  end

  def sender_distributed(email, document, recipient_emails, message)
    @document = document
    @recipient_emails = recipient_emails
    @message = message
    @expiration = document[:uploaded_at] + 30.days

    mail to: email, subject: "You shared the file #{document.name} with #{recipient_emails.count} people"
  end

  def deleted(email, document, recipients)
    @document = document
    @recipients = recipients
    byebug
    mail to: email, subject: "#{document.name} has been deleted from your CloudBeam dashboard"
  end

  def cleaned(email, document, recipients_not_downloaded, recipients_downloaded)
    @document = document
    @recipients_not_downloaded = recipients_not_downloaded
    @recipients_downloaded = recipients_downloaded
    mail to: email, subject: "#{document.name} has been deleted from your CloudBeam dashboard"
  end
end
