class User < ApplicationRecord
  validates :name, length: { within: 1..255 }
  validates :email, length: { within: 1..255 }, uniqueness: true
  validates :password, length: { within: 1..255 }
  has_secure_password
end
