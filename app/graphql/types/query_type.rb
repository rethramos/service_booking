module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, Types::User::UserResultType, null: false
    field :logout_user, Boolean, null: false
    field :service_search, Types::ServiceType.connection_type, null: false do
      argument :filter, Types::Service::ServiceSearchFilterInputType, required: false
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
  end
end
