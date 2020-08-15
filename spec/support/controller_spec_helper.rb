# spec/support/controller_spec_helper.rb
module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id, user_ip)
    JsonWebToken.encode(user_id: user_id, user_ip: user_ip)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id, user_ip)
    JsonWebToken.encode({ user_id: user_id, user_ip: user_ip }, (Time.now.to_i - 10))
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
