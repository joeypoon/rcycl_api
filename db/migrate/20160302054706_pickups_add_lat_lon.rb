class PickupsAddLatLon < ActiveRecord::Migration
  def change
    add_column :pickups, :latitude, :float
    add_column :pickups, :longitude, :float
  end
end
