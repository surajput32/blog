class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.call(user_id)
    payload = { user_id: user_id }

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode(token)
    payload = JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }

    payload[0]['user_id']
  end
end
