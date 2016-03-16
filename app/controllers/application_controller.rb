class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  def current_user
    @current_user ||= User.find session[:user_id]
  end

  def sign_in user
    session[:user_id] = user.id
  end

  private

    def authenticate_user
      redirect_to root_path unless session[:user_id] && current_user
    end
end