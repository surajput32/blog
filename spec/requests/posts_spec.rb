require 'rails_helper'

RSpec.describe '/posts', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) {
    {
      name: 'Test post',
      title: 'Test title',
      content: 'Test content'
    }
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_headers) { token_header(user.id) }

  describe 'GET /show' do
    it 'renders a successful response' do
      post = create(:post)
      create_list(:comment, 2, post: post)
      get api_v1_post_url(post), headers: valid_headers, as: :json

      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Post' do
        expect {
          post api_v1_posts_url,
               params: { post: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Post, :count).by(1)
      end

      it 'renders a JSON response with the new post' do
        post api_v1_posts_url,
             params: { post: valid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Post' do
        expect {
          post api_v1_posts_url,
               params: { post: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Post, :count).by(0)
      end

      it 'renders a JSON response with errors for the new post' do
        post api_v1_posts_url,
             params: { post: invalid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end
end
