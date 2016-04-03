require 'test_helper'

class V1::AddressesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    setup_headers @user.auth_token
  end

  test 'can post create' do
    address = attributes_for :address
    assert_difference 'Address.count' do
      post :create, address: address
      assert_response 200
      assert_not_nil assigns :address
    end
  end

  test 'can get index' do
    address = create :address, user: @user
    get :index
    assert_response 200
    assert_not_nil assigns :addresses
    assert assigns(:addresses).include?(address)
  end

  test 'can get show' do
    address = create :address
    get :show, id: address.id
    assert_response 200
    assert_not_nil assigns :address
    assert assigns(:address) == address
  end

  test 'can put update' do
    base_address = create :address
    update_address = attributes_for :address
    put :update, id: base_address.id, address: update_address
    assert base_address.reload.street == update_address[:street]
    assert base_address.reload.unit_number == update_address[:unit_number]
    assert base_address.reload.city == update_address[:city]
    assert base_address.reload.state == update_address[:state]
    assert base_address.reload.zip_code == update_address[:zip_code]
    assert_not_nil assigns :address
  end

  test 'can delete destroy' do
    address = create :address
    delete :destroy, id: address.id
    assert_response 200
  end
end
