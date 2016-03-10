class SubscribersController < ApplicationController
  skip_before_action :authenticate_token, only: [:create]

  def create
    @subscriber = Subscriber.new subscriber_params
    if @subscriber.save!
      render json: @subscriber
    else
      render json: { message: @subscriber.errors }, status: 422
    end
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
