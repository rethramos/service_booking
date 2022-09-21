# frozen_string_literal: true

module Types
  class BusinessType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :name, String
    field :timezone, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
