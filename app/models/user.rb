class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, length: { within: 1..255 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { within: 1..255 }
  has_secure_password
end
