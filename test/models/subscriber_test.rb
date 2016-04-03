require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  test 'factory is valid' do
    subscriber = build :subscriber
    assert subscriber.valid?
  end

  test 'factory validates presence of email' do
    subscriber = build :subscriber, email: nil
    assert_not subscriber.valid?
  end

  test 'factory validates uniqueness of email' do
    subscriber = create :subscriber
    subscriber = build :subscriber, email: subscriber.email
    assert_not subscriber.valid?
  end
end
