module Users::Resolvers
  class Show < Lib::Resolvers::Base
    type ::Objects::User, null: true

    argument :id, ID, required: true

    def resolve(**args)
      run Users::Show, args
      @model
    end
  end
end
