require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'factory is valid' do
    address = build :address
    assert address.valid?
  end

  test 'validates presence of user' do
    address = build :address, user: nil
    assert_not address.valid?
  end

  test 'validates presence of street' do
    address = build :address, street: nil
    assert_not address.valid?
  end

  test 'validates presence of city' do
    address = build :address, state: nil
    assert_not address.valid?
  end

  test 'validates presence of state' do
    address = build :address, state: nil
    assert_not address.valid?
  end

  test 'validates presence of zip_code' do
    address = build :address, zip_code: nil
    assert_not address.valid?
  end
end
