require 'test_helper'

class SubscriberMailerTest < ActionMailer::TestCase
  test 'welcome' do
    subscriber = create :subscriber
    email = SubscriberMailer.welcome_email(subscriber).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['kim@rcycl.co'], email.from
    assert_equal [subscriber.email], email.to
    assert_equal 'Welcome to rcycl!', email.subject
  end
end