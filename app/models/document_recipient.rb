class DocumentRecipient < ApplicationRecord
  belongs_to :document
  validates_presence_of :document_id, :shared_at, :download_code, :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
end
