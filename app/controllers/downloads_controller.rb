# frozen_string_literal: true

require 'date'

# this controller handles the download based on user's unique code
class DownloadsController < ApplicationController
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

    if recipient.downloaded_at || document.expired_at
      redirect_to downloads_url, alert: error_message(document) and return
    end

    recipient.update(downloaded_at: DateTime.now)

    DocumentRecipientChannel.broadcast_to User.find(document.user_id),
                document: document, recipient: recipient

    redirect_to signed_url(file_name(document), request.remote_ip)
  end

  private

  def signed_url(file_name, ip)
    resource = "#{Rails.application.credentials.cloudfront[:url]}#{file_name}?response-cache-control=No-cache&?response-content-disposition=attachment%3B%20filename%#{file_name}"


    # the next 5 lines of code would replace the code on lines 47-52 to restrict IP addresses
    # url = Aws::CF::Signer.sign_url resource,
    #                            expires: expiration,
    #                            resource: resource,
    #                            ip_range: "#{ip}/32"
    # url

    # this could be removed if IP identify works on production
    signer = Aws::CloudFront::UrlSigner.new({
                                              key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
                                              private_key: Rails.application.credentials.cloudfront[:private_key]
                                            })
    # this could be removed if IP identify works on production
    signer.signed_url(resource, expires: Time.now + 180)
  end

  def file_name(document)
    document[:url].split('/').last
  end

  def error_message(document)
    document.expired_at ? 'File expired' : 'Code used'
  end
end
