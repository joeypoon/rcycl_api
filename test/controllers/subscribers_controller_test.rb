require 'test_helper'

class SubscribersControllerTest < ActionController::TestCase
  test 'can post create' do
    subscriber = attributes_for :subscriber
    assert_difference 'Subscriber.count' do
      post :create, subscriber: subscriber
      assert_response 200
    end
  end
end