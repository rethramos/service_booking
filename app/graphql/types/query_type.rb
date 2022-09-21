module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, Types::User::UserResultType, null: false

    def me
      if context[:logged_in]
        context[:current_user]
      else
        :unauthenticated
      end
    end
  end
end
