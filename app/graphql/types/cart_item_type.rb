# frozen_string_literal: true

module Types
  class CartItemType < Types::BaseObject
    field :id, ID, null: false
    field :cart, Types::CartType, null: false
    field :service, Types::ServiceType, null: false
    field :appointment, Types::AppointmentType, null: false
    field :addon, String
    field :slots, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
