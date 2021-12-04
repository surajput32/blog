class Like < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
