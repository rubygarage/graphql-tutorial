class Comments::Mutations::Create < Lib::Mutations::WithUserAuthentication
  graphql_name 'createComment'
  description 'Create new comment'

  argument :task_id, ID, required: true
  argument :body, String, required: true
  argument :attachment, ApolloUploadServer::Upload, required: false

  field :comment, Objects::Comment, null: true
  field :errors, [Objects::Error], null: false

  def resolve(**args)
    result = run ::Comments::Create, args

    if result.success?
      { comment: result[:model], errors: [] }
    else
      { errors: Lib::Service::ErrorsConverter.call(result['contract.default']) }
    end
  end
end
