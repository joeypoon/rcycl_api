class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.datetime :auth_expiration
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
