class Projects::Mutations::Update < Lib::Mutations::WithUserAuthentication
  graphql_name 'updateProject'
  description 'Update project'

  argument :id, ID, required: true
  argument :title, String, required: false
  argument :position, Int, required: false

  field :project, Objects::Project, null: true
  field :errors, [Objects::Error], null: false

  def resolve(**args)
    result = run ::Projects::Update, args

    if result.success?
      { project: result[:model], errors: [] }
    else
      { errors: Lib::Service::ErrorsConverter.call(result['contract.default']) }
    end
  end
end
