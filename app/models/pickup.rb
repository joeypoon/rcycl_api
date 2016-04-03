class Pickup < ActiveRecord::Base
  belongs_to :address
  belongs_to :driver

  before_create :get_geocode
  #needed for Geocoder methods
  geocoded_by :full_address

  validates :address, :time, presence: true
  validate :valid_status?

  scope :active, -> { where.not(status: ["Picked up", "Rcycld!"]) }

  def full_address
    address.full_address
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
      self.latitude = address.latitude
      self.longitude = address.longitude
    end

end
