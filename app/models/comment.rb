class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  validates :text, length: { minimum: 2 }


  default_scope{ order(updated_at: :desc)}
end
