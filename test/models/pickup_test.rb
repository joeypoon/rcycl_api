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

  test 'validates status' do
    pickup = build :pickup, status: nil
    assert_not pickup.valid?
  end
end