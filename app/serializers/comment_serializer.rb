class CommentSerializer
  include JSONAPI::Serializer

  attributes :id, :body

  attribute :likes_count do |comment_record|
    comment_record.likes.count
  end

  belongs_to :post
  belongs_to :user
end
