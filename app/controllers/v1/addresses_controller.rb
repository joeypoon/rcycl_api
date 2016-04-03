class V1::AddressesController < ApiController
  def create
    @address = Address.new address_params.except(:default)
    @address.user = current_user
    if @address.save
      @address.mark_default if address_params[:default]
      render json: @address
    else
      render json: { message: @address.errors }, status: 422
    end
  end

  def index
    @addresses = current_user.addresses
    render json: @addresses
  end

  def show
    @address = Address.find params[:id]
    if @address.present?
      render json: @address
    else
      render json: { message: @address.errors }, status: 422
    end
  end

  def update
    @address = Address.find params[:id]
    if @address.update_attributes(address_params)
      render json: @address
    else
      render json: { message: @address.errors }, status: 422
    end
  end

  def destroy
    @address = Address.find params[:id]
    #TODO soft destroy
    if @address.destroy
      render json: { message: "Address deleted." }
    else
      render json: { message: @address.errors }, status: 422
    end
  end

  private

    def address_params
      params.require(:address).permit(
        :street, :unit_number, :city, :state, :zip_code, :default
      )
    end
end
