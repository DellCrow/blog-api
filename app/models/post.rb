class Post < ApplicationRecord
  has_and_belongs_to_many :tags, before_add: :check_tag
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user

  validates :title, length: { within: 1..255 }, uniqueness: true
  validates :description, length: { minimum: 10 }

  def check_tag(tag)
    if self.tags.include?(tag)
      raise ActiveRecord::RecordNotUnique, "Tag #{tag.id} already exists in post #{self.id}"
    end
  end
end
