require 'rails_helper'

RSpec.describe '/comments', type: :request do
  let(:user) { create(:user) }
  let(:post_obj) { create(:post) }
  let(:valid_attributes) {
    {
      body: 'Test comment body'
    }
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_headers) { token_header(user.id) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new comment' do
        expect {
          post api_v1_post_comments_url(post_obj),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Comment, :count).by(1)
      end

      it 'renders a JSON response with the new comment' do
        post api_v1_post_comments_url(post_obj),
             params: { comment: valid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        expect {
          post api_v1_post_comments_url(post_obj),
               params: { post: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Comment, :count).by(0)
      end

      it 'renders a JSON response with errors for the new comment' do
        post api_v1_post_comments_url(post_obj),
             params: { post: invalid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end
end
