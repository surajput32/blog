class Comment < ApplicationRecord
  # associations
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable
end
