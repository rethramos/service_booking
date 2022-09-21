# frozen_string_literal: true

module Types
  class ServiceType < Types::BaseObject
    field :id, ID, null: false
    field :business, Types::BusinessType, null: false
    field :service_category, Types::ServiceCategoryType
    field :name, String, null: false
    field :description, String, null: false
    field :unit_price, Float, null: false
    field :currency, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
