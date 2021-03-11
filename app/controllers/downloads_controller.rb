require 'date'

class DownloadsController < ApplicationController
  def show
    # dummy data for now. needs to be integrated with the database.
    file_name = "graham-cookies.zip"
    resource = "https://dvt9gv73mq47e.cloudfront.net/#{file_name}?response-content-disposition=attachment;"

    signer = Aws::CloudFront::UrlSigner.new({
        key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
        response_content_disposition: "attachment",
        private_key: Rails.application.credentials.cloudfront[:private_key]
      })

    # update for shorter expiration time
    @signed_url = signer.signed_url(resource, expires: Date.today + 1)
    redirect_to @signed_url
  end

  def index
    # get any id param in the url
    @download_code = params[:id]
  end

  def submit_code
    download_code = params[:download_code]
    if download_code == '' then
      @notice = "Please enter a code"
    else
      document_recipient = DocumentRecipient.find_by(download_code: download_code)
      if document_recipient == nil then
        @notice = "Invalid Code"
      else
        document = Document.find(document_recipient.document_id)
        if document_recipient.downloaded_at == nil then
          @notice = "Starting"

          user = User.find(document.user_id)

        elsif document.expired_at then
          @notice = "File expired"
        else
          @notice = "Code used"
        end
      end
    end
    render "index"
  end
end
