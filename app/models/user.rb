class User < ActiveRecord::Base
  include AuthToken
  has_secure_password

  after_create :regenerate_auth_token
  after_validation :geocode, unless: :test_env?
  geocoded_by :full_address

  has_many :pickups

  validates :street, :unit_number, :city, :state, :zip_code, presence: true
  validates :email, presence: true, uniqueness: true

  def auth_token= token
    set_auth_token token
  end

  def full_address
    "#{street} #{unit_number}, #{city}, #{state} #{zip_code}"
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

  private

    def test_env?
      Rails.env.test?
    end

end