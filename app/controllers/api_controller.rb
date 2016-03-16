class ApiController < ActionController::Base #ActionController::API
  protect_from_forgery with: :null_session
  before_action :authenticate_token

  def current_user
    @current_user ||= User.find_by_auth_token header_token
  end

  def current_driver
    @current_driver ||= Driver.find_by_auth_token header_token
  end

  private

    def header_token
      request.headers["x-auth-token"]
    end

    def authenticate_token
      if header_token.present?
        unless current_user.present? || current_driver.present?
          render json: { message: "Invalid token." }, status: 401
        end
      else
        render json: { message: "No token present." }, status: 401
      end
    end
end