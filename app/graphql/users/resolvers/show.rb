module Users::Resolvers
  class Show < GraphQL::Schema::Resolver
    type ::Objects::User, null: true

    argument :id, ID, required: true

    def resolve(**args)
      result = Users::Show.call(params: args)
      result[:model]
    end
  end
end
