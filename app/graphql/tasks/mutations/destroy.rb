class Tasks::Mutations::Destroy < Lib::Mutations::WithUserAuthentication
  graphql_name 'taskDestroy'
  description 'Delete task'

  argument :id, ID, required: true

  field :errors, [Objects::Error], null: false

  def resolve(**args)
    run ::Tasks::Destroy, args

    { errors: [] }
  end
end
