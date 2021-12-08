require 'rails_helper'

RSpec.describe User, type: :model do
  # associations
  it { should have_many(:posts) }

  describe 'Class methods' do
    describe '#all_with_posts_count_having_at_least_one_post' do
      it 'returns user ids and post counts of all users having posts' do
        create_list(:user, 2)
        posts = create_list(:post, 2)
        result = User.all_with_posts_count_having_at_least_one_post

        expect(result).to match_array(
          [
            { user_id: posts.first.user_id, number_of_posts: 1 },
            { user_id: posts.second.user_id, number_of_posts: 1 }
          ]
        )
      end
    end
  end
end
