class Tag < ApplicationRecord
  validates :name, length: { within: 3..20 }, uniqueness: true
end
