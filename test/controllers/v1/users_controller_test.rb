require 'test_helper'

class V1::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    setup_headers @user.auth_token
  end

  test 'can post create' do
    assert_difference 'User.count' do
      user = attributes_for :user
      post :create, user: user
      assert_response 200
    end
  end

  test 'can get show' do
    get :show, id: @user.id
    assert_response 200
    assert_not_nil assigns(:user)
  end

  test 'can put update' do
    user = attributes_for :user
    put :update, id: @user.id, user: user
    assert_equal @user.reload.email, user[:email]
  end

  test 'can post login' do
    post 'login', user: @user.as_json.merge(password: "password")
    assert_response 200
    assert_not_nil assigns(:user)
    binding.pry
  end
end