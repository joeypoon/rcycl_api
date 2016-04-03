class V1::UsersController < ApiController
  skip_before_action :authenticate_token, only: [:create, :login]

  def create
    @user = User.new user_params
    if @user.save!
      render json: @user
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

  def destroy
    #TODO soft delete
  end

  def login
    @user = User.find_by_email user_params[:email]
    if @user&.authenticate(user_params[:password])
      @user.regenerate_auth_token
      render json: @user
    else
      render json: { message: "Invalid email/password combination" }, status: 401
    end
  end

  private

    def user_params
      params.require(:user).permit(
          :name, :email, :password, :password_confirmation
        )
    end
end
