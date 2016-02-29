require 'test_helper'

class V1::PickupsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    setup_headers @user.auth_token
  end

  test 'can post create' do
    assert_difference 'Pickup.count' do
      pickup = build :pickup
      post :create, pickup: pickup.as_json
      assert_response 200
    end
  end

  test 'post put update' do
    pickup = create :pickup
    put :update, id: pickup.id, pickup: { user_id: @user }
    assert_equal pickup.reload.user, @user
  end

  test 'can get show' do
    pickup = create :pickup
    get :show, id: pickup.id
    assert_response 200
    assert_not_nil assigns(:pickup)
  end
end