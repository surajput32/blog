class PostSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :title, :content

  attribute :likes_count do |post_record|
    post_record.likes.count
  end

  belongs_to :user
  has_many :comments
end
