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
    redirect_to downloads_url, notice: 'Please enter a code.' and return if code.empty?

    recipient = DocumentRecipient.find_by(download_code: code)
    redirect_to downloads_url, notice: 'Invalid code.' and return if recipient.nil?

    document = Document.find(recipient.document_id)

    if recipient.downloaded_at || document.expired_at
      redirect_to downloads_url, notice: error_message(document) and return
    end

    @notice = 'Starting'
    recipient.update(downloaded_at: DateTime.now)

    redirect_to signed_url(file_name)
  end

  private

  def signed_url(file_name)
    resource = "#{Rails.application.credentials.cloudfront[:url]}#{file_name}?response-content-disposition=attachment"

    signer = Aws::CloudFront::UrlSigner.new({
                                              key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
                                              private_key: Rails.application.credentials.cloudfront[:private_key]
                                            })

    # url expires in 3 minutes
    signer.signed_url(resource, expires: Time.now + 180)
  end

  def file_name(document)
    document.url.split('/').last
  end

  def error_message(document)
    document.expired_at ? 'File expired' : 'Code used'
  end
end
