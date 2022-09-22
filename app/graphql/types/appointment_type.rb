# frozen_string_literal: true

module Types
  class AppointmentType < Types::BaseObject
    field :id, ID, null: false
    field :service, Types::ServiceType, null: false
    field :timeslot, GraphQL::Types::ISO8601DateTime, null: false
    field :max_slots, Integer, null: false
    field :remaining_slots, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def remaining_slots
      object.service.bookings.where(service_appointment: object.timeslot).sum(:slots)
    end
  end
end
