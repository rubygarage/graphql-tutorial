module Users::Resolvers
  class Me < Lib::Resolvers::WithUserAuthentication
    type ::Objects::User, null: false

    def resolve
      context[:current_user]
    end
  end
end
