class V1::DriversController < ApplicationController
  skip_before_action :authenticate_token, only: [:create, :login]

  def create
    @driver = Driver.new driver_params
    if @driver.save!
      render json: @driver.serialize(:create)
    else
      render json: { message: @driver.errors }, status: 422
    end
  end

  def show
    @driver = current_driver
    render json: @driver.serialize
  end

  def update
    @driver = current_driver
    if @driver.update_attributes(driver_params)
      render json: @driver.serialize
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
      render json: @driver.serialize(:login)
    else
      render json: { message: "Invalid email/password combination." }, status: 401
    end
  end

  def nearby_pickups
    @driver = current_driver
    distance = params[:distance] || 20
    latitude = params[:latitude]&.to_f
    longitude = params[:longitude]&.to_f

    if latitude.present? && longitude.present?
      @pickups = Pickup.near([latitude, longitude], 20)
      @pickups = Pickup.serialize_nearby(@pickups, latitude, longitude)
      render json: { pickups: @pickups }
    else
      render json: { error: "Must provide latitude and longitude." }
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