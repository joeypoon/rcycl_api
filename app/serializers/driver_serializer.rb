class DriverSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token, :auth_expiration
end
