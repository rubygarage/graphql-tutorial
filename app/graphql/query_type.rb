class QueryType < Lib::Objects::Base
  field :user, resolver: Users::Resolvers::Show, description: 'User'
end
