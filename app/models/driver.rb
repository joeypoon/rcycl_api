class Driver < ActiveRecord::Base
  include AuthToken
  has_secure_password

  after_create :regenerate_auth_token

  has_many :pickups

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def auth_token= token
    set_auth_token token
  end
end
