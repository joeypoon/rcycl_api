class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find current_user
  end

  private

    def user_params
      params.require(:user)
            .permit(:name, :email, :street, :unit_number, :city, :state,
                    :zip_code, :password, :password_confirmation)
    end
end