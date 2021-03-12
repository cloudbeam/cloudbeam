class User < ApplicationRecord
  has_secure_password
  has_many :documents, dependent: :destroy
  validates :email, uniqueness: true
end
