module AuthHelper
  def sign_in(user)
    allow(AuthenticationTokenService).to receive(:decode).and_return(user.id)
  end

  def token_header(user_id)
    token = AuthenticationTokenService.call(user_id)

    { 'Authorization' => "Bearer #{token}" }
  end
end
