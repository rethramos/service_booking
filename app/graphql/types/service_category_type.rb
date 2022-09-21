# frozen_string_literal: true

module Types
  class ServiceCategoryType < Types::BaseObject
    include Rails.application.routes.url_helpers

    field :id, ID, null: false
    field :business, Types::BusinessType, null: false
    field :image, String
    field :name, String, null: false
    field :description, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def image
      rails_blob_url(
        object.image,
        protocol: ActiveStorage::Current.url_options[:protocol],
        host: ActiveStorage::Current.url_options[:host],
        port: ActiveStorage::Current.url_options[:port]
      )
    end
  end
end
