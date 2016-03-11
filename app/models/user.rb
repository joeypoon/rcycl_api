class User < ActiveRecord::Base
  include AuthToken
  include CustomSerializer
  has_secure_password

  after_create :regenerate_auth_token
  after_validation :geocode, unless: :test_env?
  geocoded_by :full_address

  has_many :pickups

  validates :street, :city, :state, :zip_code, presence: true
  validates :email, presence: true, uniqueness: true

  def auth_token= token
    set_auth_token token
  end

  def serialize(type=:default, address=false)
    super(type)
    @result[self.class.to_s.downcase].merge!({ address: full_address }) if address
    @result
  end

  def full_address
    "#{street} #{unit_number}, #{city}, #{state} #{zip_code}"
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

  private

    def test_env?
      Rails.env.test?
    end

end