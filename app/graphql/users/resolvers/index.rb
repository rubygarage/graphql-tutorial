module Users::Resolvers
  class Index < GraphQL::Schema::Resolver
    type [::Objects::User], null: false

    def resolve
      result = Users::Index.call
      result[:model]
    end
  end
end
