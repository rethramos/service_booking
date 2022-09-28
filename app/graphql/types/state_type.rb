# frozen_string_literal: true

module Types
  class StateType < Types::BaseObject
    field :code, String, null: false
    field :name, String, null: false
  end
end
