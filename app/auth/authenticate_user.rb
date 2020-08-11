# frozen_string_literal: true

# Authenticate User by JWT
class AuthenticateUser
  def initialize(login, password)
    @login = login
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

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
end
