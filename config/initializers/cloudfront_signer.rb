Aws::CF::Signer.configure do |config|
  config.key = Rails.application.credentials.cloudfront[:private_key]
  config.key_pair_id = Rails.application.credentials.cloudfront[:public_key_id]
  config.default_expires = Time.now + 180 # 3 minutes
end
