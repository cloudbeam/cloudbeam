# frozen_string_literal: true

require 'date'

# this controller handles the download based on user's unique code
class DownloadsController < ApplicationController
  skip_before_action :session_expires, except: [:file_owner_download]
  before_action :authorize, only: [:file_owner_download]

  def index
    # get any id param in the url
    @download_code = params[:id]
  end

  def submit_code
    code = params[:download_code]
    redirect_to downloads_url, alert: 'Please enter a code.' and return if code.empty?

    recipient = DocumentRecipient.find_by(download_code: code)
    redirect_to downloads_url, alert: 'Invalid code.' and return if recipient.nil?

    document = Document.find(recipient.document_id)

    document_uploader = User.find(document.user_id)

    if recipient.downloaded_at || document.expired_at
      redirect_to downloads_url, alert: error_message(document) and return
    end

    recipient.update(downloaded_at: DateTime.now)

    # Delete the file if everyone has downloaded it
    recipients_not_downloaded = DocumentRecipient.where(document_id: document.id, downloaded_at: nil).count
    recipients = DocumentRecipient.where(document_id: document.id)
    total_recipients = recipients.count

    times_downloaded = total_recipients - recipients_not_downloaded

    if recipients_not_downloaded == 0 then
      document.update(expired_at: DateTime.now)
      DocumentMailer.deleted(document_uploader.email, document, recipients).deliver_later
    end

    DocumentRecipientChannel.broadcast_to User.find(document_uploader.id),
                document: document, recipient: recipient, times_downloaded: times_downloaded

    redirect_to signed_url(file_name(document), request.remote_ip)
  end

  def file_owner_download
    user_id = session[:user_id]
    document = Document.find(params[:document_id])

    if user_owns_file?(user_id, document)
      redirect_to signed_url(file_name(document), request.remote_ip)
    else
      redirect_to documents_url, alert: "You don't own that file."
    end
  end

  private

  def user_owns_file?(user_id, document)
    document.user_id == user_id
  end

  def signed_url(file_name, ip)
    expiration  = Time.now + 180

    resource    = "#{Rails.application.credentials.cloudfront[:url]}#{file_name}?"
    query_params = "response-content-disposition=attachment;filename=#{file_name}"

    resource += query_params

    if Rails.env.production?
      prod_signed_url(resource, expiration, ip)
    else
      local_signed_url(resource, expiration)
    end
  end

  def prod_signed_url(resource, expiration, ip)
    url = Aws::CF::Signer.sign_url resource,
                               expires: expiration,
                               resource: resource,
                               ip_range: "#{ip}/32"
    url
  end

  def local_signed_url(resource, expiration)
    signer = Aws::CloudFront::UrlSigner.new({
                                              key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
                                              private_key: Rails.application.credentials.cloudfront[:private_key]
                                            })
    signer.signed_url(resource, expires: expiration)
  end

  def file_name(document)
    document[:url].split('/').last
  end

  def error_message(document)
    document.expired_at ? 'File expired' : 'Code used'
  end
end
