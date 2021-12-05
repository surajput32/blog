module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      skip_before_action :authenticate_user, only: :create
      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        raise AuthenticationError unless user.authenticate(params.require(:password))
        token = AuthenticationTokenService.call(user.id)

        render json: { token: token }, status: :created
      end

      private

      def user
        @user ||= User.find_by(name: params.require(:name))
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end
