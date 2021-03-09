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
end
