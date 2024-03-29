module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :receipts, [Types::ReceiptType], null: false
    def receipts
      ::Receipt.all
    end
    field :me, Types::User::UserResultType, null: false
    field :logout_user, Boolean, null: false
    field :service_search, Types::ServiceType.connection_type, null: false do
      argument :filter, Types::Service::ServiceSearchFilterInputType, required: false
    end
    field :service, Types::ServiceType do
      argument :id, ID, required: true
    end
    field :payment_options, [Types::PaymentOptionType], null: false
    field :receipt, Types::ReceiptType do
      argument :id, ID, required: true
    end
    field :countries, [Types::CountryType], null: false
    field :states, [Types::StateType], null: false do
      argument :country_code, String, required: true
    end
    field :cities, [String], null: false do
      argument :state_code, String, required: false
      argument :country_code, String, required: true
    end

    def me
      if context[:logged_in]
        context[:current_user]
      else
        :unauthenticated
      end
    end

    def logout_user
      context[:session][:user_id] = nil
      if context[:session][:user_id].nil?
        true
      else
        false
      end
    end

    def service_search(filter: {})
      relation = ::Service.all
      relation = relation.where('name LIKE ?', "%#{filter[:name_contains]}%") if filter[:name_contains]
      relation
    end

    def service(id: 0)
      ::Service.find(id)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def payment_options
      PaymentOption.all
    end

    def receipt(id: 0)
      ::Receipt.find(id)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def countries
      CS.countries.map do |k,v|
        { code: k, name: v }
      end
    end

    def states(country_code:)
      CS.states(country_code).map do |k, v|
        { code: k, name: v }
      end
    end

    def cities(state_code:, country_code:)
      res = CS.cities(state_code, country_code)
      if res.is_a? Array
        res
      else
        []
      end
    end
  end
end
