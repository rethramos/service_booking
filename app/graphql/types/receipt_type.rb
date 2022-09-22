# frozen_string_literal: true

module Types
  class ReceiptType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :payment_option, Types::PaymentOptionType, null: false
    field :address, Types::AddressType, null: false
    field :bookings, [Types::BookingType], null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :contact_number, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
