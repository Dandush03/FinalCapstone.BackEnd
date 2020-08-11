# frozen_string_literal: true

# app/lib/json_web_token.rb
class JsonWebToken
  # secret to encode and decode token
  JWT_SECRET = Rails.application.credentials.secret_key_jwt

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, JWT_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, JWT_SECRET)[0]
    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
