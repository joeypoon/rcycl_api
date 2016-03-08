class Pickup < ActiveRecord::Base
  include CustomSerializer
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

  def self.serialize_nearby(pickups, latitude, longitude)
    pickups.map do |pickup|
      address = User.find(pickup.user_id).full_address
      distance = pickup.distance_from([latitude, longitude])
      pickup = pickup.serialize(:nearby)["pickup"]
      pickup.merge({ address: address, distance: distance })
    end
  end

  def full_address
    user.full_address
  end

  def status=(options)
    self.picked_up_at = Time.now if options&.downcase == "picked up"
    super
  end

  def time=(options)
    options = Time.at(options) if options.class == Fixnum
    super
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