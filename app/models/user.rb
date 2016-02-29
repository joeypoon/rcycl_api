class User < ActiveRecord::Base
  include AuthToken
  has_secure_password
  after_create :regenerate_auth_token

  validates :street, :unit_number, :city, :state, :zip_code, presence: true
  validates :email, presence: true, uniqueness: true
  #TODO email verification

  def auth_token= token
    set_auth_token token
  end
end