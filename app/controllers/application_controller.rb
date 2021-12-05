class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  before_action :authenticate_user

  private

  def parameter_missing(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def authenticate_user
    token, _ = token_and_options(request)
    @user_id = AuthenticationTokenService.decode(token)
    current_user
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

  def current_user
    @current_user ||= User.find(@user_id)
  end
end
