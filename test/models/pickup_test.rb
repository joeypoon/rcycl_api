require 'test_helper'

class PickupTest < ActiveSupport::TestCase
  test 'factory is valid' do
    pickup = create :pickup
    assert pickup.valid?
  end

  test 'validates presence of user' do
    pickup = build :pickup, user: nil
    assert_not pickup.valid?
  end

  test 'validates presence of time' do
    pickup = build :pickup, time: nil
    assert_not pickup.valid?
  end

  test 'validates status' do
    pickup = build :pickup, status: nil
    assert_not pickup.valid?
  end

  test 'gets lat and lon after create' do
    lat = 100
    lon = 100
    user = create :user, latitude: lat, longitude: lon
    pickup = create :pickup, user: user
    assert_equal pickup.latitude, lat
    assert_equal pickup.longitude, lon
  end
end