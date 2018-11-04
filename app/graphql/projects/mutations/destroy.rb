class Projects::Mutations::Destroy < Lib::Mutations::WithUserAuthentication
  graphql_name 'destroyProject'
  description 'Delete project'

  argument :id, ID, required: true

  field :errors, [Objects::Error], null: false

  def resolve(**args)
    run ::Projects::Destroy, args

    { errors: [] }
  end
end
