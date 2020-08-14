module Api
  module Auth
    # Authentication Controller
    class AuthenticationController < ApplicationController
      skip_before_action :authorize_request, only: %i[authenticate create]
      def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.email, user.password).call
        response = { message: Message.account_created, auth_token: auth_token }
        render json: response, status: :created
      end

      def authenticate
        auth_token =
          AuthenticateUser.new(auth_params[:login], auth_params[:password]).call
        render json: { auth_token: auth_token }
      end

      def authorize
        render json: nil, status: :ok
      end

      private

      def auth_params
        params.permit(:login, :password)
      end

      def user_params
        params.permit(
          :full_name,
          :username,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
