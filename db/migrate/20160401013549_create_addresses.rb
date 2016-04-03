class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :street
      t.string :unit_number
      t.string :city
      t.string :state
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.boolean :default, default: false

      t.timestamps null: false
    end

    remove_column :users, :street, :string
    remove_column :users, :unit_number, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :zip_code, :integer
    remove_column :users, :latitude, :float
    remove_column :users, :longitude, :float
    remove_column :pickups, :user_id, :integer
    add_column :pickups, :address_id, :integer
  end
end
