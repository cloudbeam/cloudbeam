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

    # Delete the file if everyone has downloaded it

    recipients_not_downloaded = DocumentRecipient.where(document_id: document.id, downloaded_at: nil).count

    if recipients_not_downloaded == 0 then
      document.update(expired_at: DateTime.now)
    end

    DocumentRecipientChannel.broadcast_to User.find(document.user_id),
                document: document, recipient: recipient

    redirect_to signed_url(file_name(document), request.remote_ip)
  end

  private

  def signed_url(file_name, ip)
    expiration  = Time.now + 180
    resource    = "#{Rails.application.credentials.cloudfront[:url]}#{file_name}?response-cache-control=No-cache&?response-content-disposition=attachment%3B%20filename%#{file_name}"

    #puts "***********\n\n\n#{Rails.env.production?}\n\n*****************"
    # the next 5 lines of code would replace the code on lines 47-52 to restrict IP addresses
    # url = Aws::CF::Signer.sign_url resource,
    #                            expires: expiration,
    #                            resource: resource,
    #                            ip_range: "#{ip}/32"
    # url

    # this could be removed if IP identify works on production
    # signer = Aws::CloudFront::UrlSigner.new({
    #                                           key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
    #                                           private_key: Rails.application.credentials.cloudfront[:private_key]
    #                                         })
    # this could be removed if IP identify works on production
    #signer.signed_url(resource, expires: expiration)

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
