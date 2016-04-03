class Address < ActiveRecord::Base
  belongs_to :user
  has_many :pickups
  after_save :force_default, if: :only_address?
  validates :user, :street, :city, :state, :zip_code, presence: true

  after_validation :geocode, unless: :test_env?
  geocoded_by :full_address

  def full_address
    "#{street} #{unit_number}, #{city}, #{state} #{zip_code}"
  end

  def mark_default
    user.addresses.update_all(default: false)
    default = true
  end

  private

    def only_address?
      user.addresses.count == 1
    end

    def force_default
      default = true
    end

    def test_env?
      Rails.env.test?
    end
end
