class DriversRemoveLatLon < ActiveRecord::Migration
  def change
    remove_column :drivers, :latitude, :float
    remove_column :drivers, :longitude, :float
  end
end
