class Tasks::Mutations::Create < Lib::Mutations::WithUserAuthentication
  graphql_name 'createTask'
  description 'Create new task'

  argument :project_id, ID, required: true
  argument :name, String, required: true

  field :task, Objects::Task, null: true
  field :errors, [Objects::Error], null: false

  def resolve(**args)
    result = run ::Tasks::Create, args

    if result.success?
      { task: result[:model], errors: [] }
    else
      { errors: Lib::Service::ErrorsConverter.call(result['contract.default']) }
    end
  end
end
