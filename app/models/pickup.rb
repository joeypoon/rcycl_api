class Pickup < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver

  before_create :get_geocode
  #needed for Geocoder methods
  geocoded_by :full_address

  validates :user, :time, presence: true
  validate :valid_status?

  scope :active, -> { where.not(status: ["Picked up", "Rcycld!"]) }

  def self.default_params
    [:user_id, :driver_id, :time, :picked_up_at, :status]
  end

  def self.nearby_params
    self.default_params - [:driver_id, :picked_up_at]
  end

  def self.serialize_nearby(pickups)
    pickups.map do |pickup|
      pickup = pickup.as_json(only: Pickup.nearby_params)
      user = User.find(pickup["user_id"]).as_json(only: User.default_params)
      pickup.merge({ user: user })
    end
  end

  def full_address
    user.full_address
  end

  private

    def valid_statuses
      ["Scheduled", "On the way", "Picked up", "Rcycld!"]
    end

    def valid_status?
      unless valid_statuses.include? status
        errors.add(:pickup, "Invalid status")
      end
    end

    def get_geocode
      self.latitude = user.latitude
      self.longitude = user.longitude
    end

end