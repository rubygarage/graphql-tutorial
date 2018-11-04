class Projects::Mutations::Create < Lib::Mutations::WithUserAuthentication
  graphql_name 'createProject'
  description 'Create new project'

  argument :title, String, required: true

  field :project, Objects::Project, null: true
  field :errors, [Objects::Error], null: false

  def resolve(**args)
    result = run ::Projects::Create, args

    if result.success?
      { project: result[:model], errors: [] }
    else
      { errors: Lib::Service::ErrorsConverter.call(result['contract.default']) }
    end
  end
end
