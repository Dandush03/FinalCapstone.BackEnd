# spec/support/controller_spec_helper.rb
module ControllerSpecHelper
  # Generate Token
  def token_creator
    loop do
      token = SecureRandom.hex(20)
      break token unless Token.where(token: token).exists?
    end
  end

  # Grant Access from user id
  def token_generator(user_id, user_ip)
    return unless user_id
    user = User.find(user_id)

    access_token = user.tokens.create(token: token_creator, request_ip: user_ip)
    JsonWebToken.encode(
      token: access_token.token,
      request_ip: access_token.request_ip
    )
  end

  def invalid_token_generator(_user_id, user_ip)
    JsonWebToken.encode(
      token: token_creator,
      request_ip: user_ip
    )
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id, user_ip)
    user = User.find(user_id)

    access_token = user.tokens.create(token: token_creator, request_ip: user_ip)
    JsonWebToken.encode(
      {
        token: access_token.token,
        request_ip: access_token.request_ip
      }, (Time.now.to_i - 10)
    )
  end

  # return valid headers
  def valid_headers
    {
      'Authorization' => token_generator(user.id, '127.0.0.1'),
      'Content-Type' => 'application/json'
    }
  end

  # return invalid headers
  def invalid_headers
    {
      'Authorization' => nil,
      'Content-Type' => 'application/json'
    }
  end
end
