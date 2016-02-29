class CreatePickups < ActiveRecord::Migration
  def change
    create_table :pickups do |t|
      t.integer :user_id
      t.integer :driver_id
      t.datetime :time
      t.datetime :picked_up_at
      t.string :status, default: "Scheduled"

      t.timestamps null: false
    end
  end
end