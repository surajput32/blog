class Post < ApplicationRecord
  # associations
  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable
end
