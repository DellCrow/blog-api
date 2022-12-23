class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :name, length: { within: 3..20 }, uniqueness: true

  default_scope{ order(:name)}

  scope :starting_with, -> (word) {where("name LIKE ?", "#{word}%")}
end
