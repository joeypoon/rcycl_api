require 'test_helper'

class PickupTest < ActiveSupport::TestCase
  test 'factory is valid' do
    pickup = create :pickup
    assert pickup.valid?
  end

  test 'validates presence of address' do
    pickup = build :pickup, address: nil
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
    address = create :address, latitude: lat, longitude: lon
    pickup = create :pickup, address: address
    assert_equal pickup.latitude, lat
    assert_equal pickup.longitude, lon
  end

  test 'will set picked_up_at when status is set to Picked Up' do
    pickup = create :pickup
    assert pickup.picked_up_at.nil?
    pickup.status = "Picked Up"
    assert_not_nil pickup.picked_up_at
  end

  test 'can set time as int' do
    pickup = create :pickup, time: Time.now.to_i
    assert pickup.valid?
  end
end
