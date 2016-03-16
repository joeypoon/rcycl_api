class SubscribersAddZipCode < ActiveRecord::Migration
  def change
    add_column :subscribers, :zip_code, :string
    change_column :users, :zip_code, :string
  end
end
