class V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :street, :unit_number, :city, :state,
             :zip_code
end