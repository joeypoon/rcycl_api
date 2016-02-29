require 'test_helper'

class DriverTest < ActiveSupport::TestCase
  test 'factory is valid' do
    driver = build :driver
    assert driver.valid?
  end

  test 'validates presence of name' do
    driver = build :driver, name: nil
    assert_not driver.valid?
  end

  test 'validates presence of email' do
    driver = build :driver, email: nil
    assert_not driver.valid?
  end

  test 'validates uniqueness of email' do
    driver = create :driver
    driver2 = build :driver, email: driver.email
    assert_not driver2.valid?
  end

  test 'generates auth token on create' do
    driver = create :driver
    assert_not_nil driver.auth_token
  end
end