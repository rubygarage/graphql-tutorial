class QueryType < Lib::Objects::Base
  field :users, resolver: Users::Resolvers::Index, description: 'All users'
  field :user, resolver: Users::Resolvers::Show, description: 'User'
end
