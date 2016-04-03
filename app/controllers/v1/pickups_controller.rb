class V1::PickupsController < ApiController
  def index
    @driver = current_driver
    distance = params[:distance] || 20
    latitude = params[:latitude]&.to_f
    longitude = params[:longitude]&.to_f

    if latitude.present? && longitude.present?
      @pickups = Pickup.near([latitude, longitude], distance)
      render json: { pickups: @pickups }
    else
      render json: { error: "Must provide latitude and longitude." }
    end
  end

  def create
    @pickup = Pickup.new pickup_params
    if @pickup.save!
      render json: @pickup
    else
      render json: { message: @pickup.errors }, status: 422
    end
  end

  def update
    @pickup = Pickup.find params[:id]
    if @pickup.update_attributes(pickup_params)
      render json: @pickup
    else
      render json: { message: @pickup.errors }, status: 422
    end
  end

  def show
    @pickup = Pickup.find params[:id]
    render json: @pickup
  end

  def destroy
    #TODO soft delete
  end

  private

    def pickup_params
      params.require(:pickup).permit(:address_id, :time, :driver_id, :status)
    end
end
