class UsersController < ApplicationController
  skip_before_action :authenticate_token, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  private

    def user_params
      params.require(:user)
            .permit(:name, :email, :street, :unit_number, :city, :state,
                    :zip_code, :password, :password_confirmation)
    end
end