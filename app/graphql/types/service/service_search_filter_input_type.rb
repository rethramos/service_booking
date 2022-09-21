# frozen_string_literal: true

module Types
  class Service::ServiceSearchFilterInputType < Types::BaseInputObject
    argument :name_contains, String, required: false
  end
end
