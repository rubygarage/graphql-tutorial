class ApplicationSchema < GraphQL::Schema
  mutation(MutationType)
  query(QueryType)
end
