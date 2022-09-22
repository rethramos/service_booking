# frozen_string_literal: true

module Types
  class Address::AddressInputType < Types::BaseInputObject
    argument :line_one, String, required: true
    argument :line_two, String, required: true
    argument :city, String, required: true
    argument :province, String, required: true
    argument :country, String, required: true
    argument :postal_code, String, required: true
  end
end
