class V1::DriversController < ApiController
  skip_before_action :authenticate_token, only: [:create, :login]

  def create
    @driver = Driver.new driver_params
    if @driver.save!
      render json: @driver
    else
      render json: { message: @driver.errors }, status: 422
    end
  end

  def show
    @driver = current_driver
    render json: @driver
  end

  def update
    @driver = current_driver
    if @driver.update_attributes(driver_params)
      render json: @driver
    else
      render json: { message: @driver.errors }, status: 422
    end
  end

  def destroy
    #TODO soft delete
  end

  def login
    @driver = Driver.find_by_email driver_params[:email]
    if @driver&.authenticate(driver_params[:password])
      @driver.regenerate_auth_token
      render json: @driver
    else
      render json: { message: "Invalid email/password combination." }, status: 401
    end
  end

  private

    def driver_params
      params.require(:driver).permit(
          :name, :email, :password, :password_confirmation, :latitude,
          :longitude
        )
    end
end
