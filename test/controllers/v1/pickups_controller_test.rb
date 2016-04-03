require 'test_helper'

class V1::PickupsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    setup_headers @user.auth_token
  end

  test 'can get index' do
    latitude = 45.23
    longitude = -93.11
    address = create :address, latitude: latitude, longitude: longitude
    pickup = create :pickup, address: address
    get :index, latitude: latitude - 0.1, longitude: longitude - 0.1
    assert_response 200
    assert_not_nil assigns(:pickups)
    assert assigns(:pickups).include?(pickup)
  end

  test 'can post create' do
    assert_difference 'Pickup.count' do
      pickup = build :pickup
      post :create, pickup: pickup.as_json
      assert_response 200
    end
  end

  test 'post put update' do
    address = create :address
    pickup = create :pickup
    put :update, id: pickup.id, pickup: { address_id: address.id }
    assert_equal pickup.reload.address, address
  end

  test 'can get show' do
    pickup = create :pickup
    get :show, id: pickup.id
    assert_response 200
    assert_not_nil assigns(:pickup)
  end
end
