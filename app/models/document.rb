class Document < ApplicationRecord
  has_one_attached :upload
  belongs_to :user
  has_many :document_recipients, dependent: :destroy
  validates :name, format: { with: /\A[\d|\w]+[\d|\w|.| -]+[\d|\w]+(\(\d\))?\z/i, message: 'Invalid filename formatting!'},
                   presence: true

  S3_BUCKET_BASE_URL = Rails.application.credentials[:bucket_url]

  # create url to access file in bucket
  def calculate_s3_url(s3_key, base_url)
    base_url + s3_key
  end

  # return current date time
  def current_date_time
    DateTime.now
  end

  def append_counter_if_redundant_name(id, file_name) 
    redundant_file_names = redundant_filenames(id, "#{file_name}")
    self[:name] = file_name + "(#{redundant_file_names})" if redundant_file_names.positive?
  end

  # set properties on object that are unset after initial creation from params
  def set_properties_after_upload(id, key)
    self[:url] = self.calculate_s3_url(key, S3_BUCKET_BASE_URL)
    self[:uploaded_at] = self.current_date_time
  end
 
  def redundant_filenames(id, regex)
    Document.where(user_id: id).where(expired_at: nil).where('name ~* ?', regex).to_a.size
  end
end
