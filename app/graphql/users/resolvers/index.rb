module Users::Resolvers
  class Index < Lib::Resolvers::Base
    type [::Objects::User], null: false

    def resolve
      run Users::Index
      @model
    end
  end
end
