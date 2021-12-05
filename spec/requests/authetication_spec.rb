require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { create(:user, password: 'Password') }
    let(:token) { AuthenticationTokenService.call(user.id) }

    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { name: user.name, password: user.password }

      expect(response).to have_http_status(:created)
      expect(JSON(response.body)).to eq({
        'token' => token
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { name: user.name, password: 'incorrect' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
