class Comment < ApplicationRecord
  belongs_to :post
  validates :text, length: { minimum: 2 }


  default_scope{ order(updated_at: :desc)}
end
