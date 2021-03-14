class Document < ApplicationRecord
  has_one_attached :upload
  belongs_to :user
  has_many :document_recipients, dependent: :destroy

  S3_BUCKET_BASE_URL = Rails.application.credentials[:bucket_url]

  # create url to access file in bucket
  def calculate_s3_url(s3_key, base_url)
    base_url + s3_key
  end

  # return current date time
  def current_date_time
    DateTime.now
  end

  # set properties on object that are unset after initial creation from params
  def set_properties_after_upload(id, key)
    self[:url] = self.calculate_s3_url(key, S3_BUCKET_BASE_URL)
    self[:uploaded_at] = self.current_date_time
  end
end
