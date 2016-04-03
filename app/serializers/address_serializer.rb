class AddressSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :street, :unit_number, :city, :state, :zip_code,
             :full_address
end
