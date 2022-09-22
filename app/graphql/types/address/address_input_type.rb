# frozen_string_literal: true

module Types
  class Address::AddressInputType < Types::BaseInputObject
    argument :line_one, String, null: false
    argument :line_two, String, null: false
    argument :city, String, null: false
    argument :province, String, null: false
    argument :country, String, null: false
    argument :postal_code, String, null: false
  end
end
