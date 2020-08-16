# Authenticate User by JWT
class AuthenticateUser
  def initialize(login, password, request_ip)
    @login = login
    @password = password
    @request_ip = request_ip
  end

  # Service entry point
  def call
    return unless user

    access_token = set_access_token
    JsonWebToken.encode(
      token: access_token.token,
      request_ip: access_token.request_ip
    )
  end

  private

  attr_reader :email, :password, :request_ip

  # verify user credentials
  def find_user
    user = User.find_by(email: @login)
    return user if user

    User.find_by(username: @login)
  end

  def user
    user = find_user
    return user if user&.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

  def set_access_token
    user.tokens.create(token: token_creator, request_ip: @request_ip)
  end

  def token_creator
    loop do
      token = SecureRandom.hex(20)
      break token unless Token.where(token: token).exists?
    end
  end
end
