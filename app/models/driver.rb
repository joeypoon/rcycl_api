class Driver < ActiveRecord::Base
  include AuthToken
  include CustomSerializer
  has_secure_password

  after_create :regenerate_auth_token

  has_many :pickups

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def auth_token= token
    set_auth_token token
  end

  def self.default_params
    [:id, :name, :email]
  end

  def self.create_params
    default_params + [:auth_token, :auth_expiration]
  end

  def self.login_params
    [:id, :auth_token, :auth_expiration]
  end
end