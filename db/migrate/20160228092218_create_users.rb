class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :street
      t.string :unit_number
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :auth_token
      t.datetime :auth_expiration

      t.timestamps null: false
    end
  end
end