require 'test_helper'

class V1::DriversControllerTest < ActionController::TestCase
  setup do
    @driver = create :driver
    setup_headers @driver.auth_token
  end

  test 'can post create' do
    assert_difference 'Driver.count' do
      driver = attributes_for :driver
      post :create, driver: driver
      assert_response 200
    end
  end

  test 'can get show' do
    get :show, id: @driver.id
    assert_response 200
    assert_not_nil assigns(:driver)
  end

  test 'can put update' do
    driver = attributes_for :driver
    put :update, id: @driver.id, driver: driver
    assert_equal @driver.reload.email, driver[:email]
  end

  test 'can post login' do
    post 'login', driver: @driver.as_json.merge(password: "password")
    assert_response 200
    assert_not_nil assigns(:driver)
  end

  test 'can get nearby pickups' do
    latitude = 45.23
    longitude = -93.11
    user = create :user, latitude: latitude, longitude: longitude
    pickup = create :pickup, user: user
    get 'nearby_pickups', latitude: latitude - 0.1, longitude: longitude - 0.1
    assert_response 200
    assert_not_nil assigns(:pickups)
    binding.pry
  end
end