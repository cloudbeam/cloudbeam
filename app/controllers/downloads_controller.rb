require 'date'

class DownloadsController < ApplicationController
  def index
    # get any id param in the url
    @download_code = params[:id]
  end

  def submit_code
    download_code = params[:download_code]
    if download_code == '' then
      redirect_to downloads_url, notice: "Please enter a code."
      return
    else
      document_recipient = DocumentRecipient.find_by(download_code: download_code)
      if document_recipient == nil then
        redirect_to downloads_url, notice: "Invalid code."
      else
        document = Document.find(document_recipient.document_id)
        if document_recipient.downloaded_at == nil then
          @notice = "Starting"
          document_recipient.update(downloaded_at: DateTime.now)

          charArr = document.url.split("/")
          name = charArr[charArr.length - 1]
          resource = "https://dvt9gv73mq47e.cloudfront.net/#{name}?response-content-disposition=attachment"

          signer = Aws::CloudFront::UrlSigner.new({
            key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
            private_key: Rails.application.credentials.cloudfront[:private_key]
          })

          # update for shorter expiration time
          @signed_url = signer.signed_url(resource, expires: Date.today + 1)
          redirect_to @signed_url

          user = User.find(document.user_id)

          return

        elsif document.expired_at then
          @notice = "File expired"
        else
          @notice = "Code used"
        end
      end
    end
  end
end
