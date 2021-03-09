require 'date'

class DownloadsController < ApplicationController
  def show
    file_name = "graham-cookies.zip"
    resource = "https://d1u2b9f4x0ygob.cloudfront.net/#{file_name}?response-content-disposition=attachment;"

    signer = Aws::CloudFront::UrlSigner.new({
        key_pair_id: Rails.application.credentials.cloudfront[:public_key_id],
        response_content_disposition: "attachment",
        private_key: Rails.application.credentials.cloudfront[:private_key]
      })

    @signed_url = signer.signed_url(resource, expires: Date.today + 1)
    puts "*****************\nSigned URL: #{@signed_url}\n********************"
    redirect_to @signed_url
  end
end
