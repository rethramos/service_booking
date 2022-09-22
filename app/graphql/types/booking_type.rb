# frozen_string_literal: true

module Types
  class BookingType < Types::BaseObject
    field :id, ID, null: false
    field :receipt, Types::ReceiptType, null: false
    field :service, Types::ServiceType
    field :booking_status, Types::BookingStatusType
    field :service_name, String, null: false
    field :service_appointment, GraphQL::Types::ISO8601DateTime, null: false
    field :service_unit_price, Float, null: false
    field :service_currency, String, null: false
    field :slots, Integer, null: false
    field :addon, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
