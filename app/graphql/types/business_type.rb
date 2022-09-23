# frozen_string_literal: true

module Types
  class BusinessType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :address, Types::AddressType
    field :formatted_address, String, null: false, fallback_value: ''
    field :name, String
    field :timezone, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def formatted_address
      if object.address.blank?
        ''
      else
        str = [object.address.line_one, object.address.line_two, object.address.city, object.address.province,
               object.address.country].join ', '
        str += " #{object.address.postal_code}"
        str
      end
    end
  end
end
