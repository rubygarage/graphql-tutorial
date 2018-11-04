class Sessions::Mutations::Create < Lib::Mutations::Base
  graphql_name 'createSession'
  description 'Sign In'

  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Objects::User, null: true
  field :token, String, null: true
  field :errors, [Objects::Error], null: false

  def resolve(**args)
    result = run Sessions::Create, args

    return { user: result[:model], token: result[:token], errors: [] } if result.success?

    raise GraphQL::ExecutionError, 'You entered wrong email or password'
  end
end
