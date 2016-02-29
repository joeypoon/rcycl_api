class User < ActiveRecord::Base
  include AuthToken
  has_secure_password
  after_create :regenerate_auth_token

  validates :street, :unit_number, :city, :state, :zip_code, presence: true
  validates :email, presence: true, uniqueness: true

  def auth_token= token
    set_auth_token token
  end

  def self.default_params
    [:id, :name, :email, :street, :unit_number, :city, :state, :zip_code]
  end

  def self.create_params
    default_params + [:auth_token]
  end

  def self.login_params
    [:auth_token]
  end
end