# frozen_string_literal: true

module Types
  class AddressType < Types::BaseObject
    field :id, ID, null: false
    field :addressable_type, String, null: false
    field :addressable_id, Integer, null: false
    field :line_one, String, null: false
    field :line_two, String, null: false
    field :city, String, null: false
    field :province, String, null: false
    field :country, String, null: false
    field :postal_code, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
