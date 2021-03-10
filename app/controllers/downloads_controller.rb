class DownloadsController < ApplicationController
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
