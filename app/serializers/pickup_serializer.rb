class PickupSerializer < ActiveModel::Serializer
  attributes :id, :address_id, :driver_id, :time, :picked_up_at, :status,
             :latitude, :longitude, :full_address
end
