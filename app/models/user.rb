class User < ApplicationRecord
  has_secure_password

  # associations
  has_many :posts

  def self.all_with_posts_count_having_at_least_one_post
    joins(:posts)
      .distinct
      .select('users.id, COUNT(posts.id) AS number_of_posts')
      .group('users.id')
      .map do |user|
        { user_id: user.id, number_of_posts: user.number_of_posts }
      end
  end
end
