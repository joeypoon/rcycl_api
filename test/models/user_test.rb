require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'factory is valid' do
    user = build :user
    assert user.valid?
  end

  test 'validates presence of email' do
    user = build :user, email: nil
    assert_not user.valid?
  end

  test 'validates uniqueness of email' do
    user = create :user
    user2 = build :user, email: user.email
    assert_not user2.valid?
  end

  test 'validates presence of street' do
    user = build :user, street: nil
    assert_not user.valid?
  end

  test 'validates presence of city' do
    user = build :user, state: nil
    assert_not user.valid?
  end

  test 'validates presence of state' do
    user = build :user, state: nil
    assert_not user.valid?
  end

  test 'validates presence of zip_code' do
    user = build :user, zip_code: nil
    assert_not user.valid?
  end

  test 'generates auth token on create' do
    user = create :user
    assert_not_nil user.auth_token
  end
end