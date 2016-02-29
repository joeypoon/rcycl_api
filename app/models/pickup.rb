class Pickup < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver

  validates :user, presence: true
  validate :valid_status?

  scope :active, -> { where.not(status: ["Picked up", "Rcycld!"]) }

  def self.default_params
    [:user_id, :driver_id, :time, :picked_up_at, :status]
  end

  private

    def valid_statuses
      ["Scheduled", "On the way", "Picked up", "Rcycld!"]
    end

    def valid_status?
      unless valid_statuses.include? self.status
        errors.add(:pickup, "Invalid status")
      end
    end
end