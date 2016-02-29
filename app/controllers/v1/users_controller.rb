class V1::UsersController < ApplicationController
  skip_before_action :authenticate_token, only: [:create, :login]

  def create
    @user = User.new user_params
    if @user.save!
      user = @user.as_json(except: create_params)
      render json: { user: user }
    else
      render json: { message: @user.errors }, status: 422
    end
  end

  def show
    @user = current_user
    render json: @user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      render json: @user
    else
      render json: { message: @user.errors }, status: 422
    end
  end

  def login
    @user = User.find_by_email user_params[:email]
    if @user&.authenticate(user_params[:password])
      @user.regenerate_auth_token
      render json: @user.as_json(only: login_params)
    else
      render json: { message: "Invalid email/password combination" }, status: 401
    end
  end

  private

    def create_params
      [:password_digest, :created_at, :updated_at]
    end

    def login_params
      [:auth_token]
    end

    def user_params
      params.require(:user).permit(
          :name, :email, :password, :password_confirmation, :street,
          :unit_number, :city, :state, :zip_code
        )
    end
end