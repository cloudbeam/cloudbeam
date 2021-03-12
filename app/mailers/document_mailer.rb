class DocumentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.file_entity_mailer.distributed.subject
  #
  default from: "John Doe <jimbot842@gmail.com>"
  def distributed(email, message, download_code)
    puts email, message
    @greeting = "Hi"
    @message = message

    @download_code = download_code

    mail to: email, subject: 'File sent'
  end

  def sender_distributed(email, document_name, recipients)
    puts "Email sender of the file"
    @document_name = document_name

    @recipients = recipients

    mail to: email, subject: 'File distributed'
  end
end
