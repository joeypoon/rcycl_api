class V1::PickupsController < ApplicationController
  def create
    @pickup = Pickup.new pickup_params
    if @pickup.save!
      render json: @pickup.serialize
    else
      render json: { message: @pickup.errors }, status: 422
    end
  end

  def update
    @pickup = Pickup.find params[:id]
    if @pickup.update_attributes(pickup_params)
      render json: @pickup.serialize
    else
      render json: { message: @pickup.errors }, status: 422
    end
  end

  def show
    @pickup = Pickup.find params[:id]
    render json: @pickup.serialize
  end

  def destroy
    #TODO soft delete
  end

  private

    def pickup_params
      params.require(:pickup).permit(:user_id, :time, :driver_id, :status)
    end
end