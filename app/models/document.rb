class Document < ApplicationRecord
  has_one_attached :upload
  belongs_to :user
  has_many :document_recipients, dependent: :destroy

  S3_BUCKET_BASE_URL = Rails.application.credentials[:bucket_url]

  # create url to access file in bucket
  def calculate_s3_url(s3_key, base_url)
    base_url + s3_key
  end

  # this will be offset to a chron job so don't set it now
  # given a date, return new date time exactly 30 days later
  def calculate_expire_date(upload_date)
    upload_date.days_since(30)
  end

  # return current date time
  def get_current_date_time
    DateTime.now
  end

  # set properties on object that are unset after initial creation from params
  def set_properties_after_upload(id, key)
    self[:url] = self.calculate_s3_url(key, S3_BUCKET_BASE_URL)
    self[:uploaded_at] = self.get_current_date_time
  end

  # maybe instead of having to hit a db query for these numbers, we can set
  # a property for this on the document itself?
  def find_total_times_shared
    DocumentRecipient.where(document_id: self.id).size
  end

  def find_total_times_downloaded
    DocumentRecipient.where("document_id = :id and downloaded_at IS NOT NULL", id: self.id).size
  end
end
