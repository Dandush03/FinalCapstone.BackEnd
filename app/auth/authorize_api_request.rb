# Api Authentication Controller
class AuthorizeApiRequest
  def initialize(headers = {}, request_ip = '')
    @headers = headers
    @request_ip = request_ip
  end

  # Service entry point - return valid user object
  def call
    {
      user: user_authentication
    }
  end

  private

  attr_reader :headers, :request_ip

  def user_authentication
    # check if user_ip = request_ip

    # check if user is in the database
    # memoize user object
    @user ||= auth_token.user if auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  def auth_token
    token = Token.find_by_token(decoded_auth_token[:token])
    raise(ExceptionHandler::InvalidToken, Message.invalid_token) unless token

    raise(ExceptionHandler::InvalidIp, Message.invalid_ip) if token.request_ip != request_ip
    
    token
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
