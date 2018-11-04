class ApplicationSchema < GraphQL::Schema
  include ::ErrorHandler

  mutation(MutationType)
  query(QueryType)
end
