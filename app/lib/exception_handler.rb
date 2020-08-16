# Handle Auth Exception
module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class InvalidIp < StandardError; end
  class InvalidTokenAge < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidIp, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidTokenAge, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(error_msg)
    render json: { message: error_msg.message }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(error_msg)
    render json: { message: error_msg.message }, status: :unauthorized
  end
end
