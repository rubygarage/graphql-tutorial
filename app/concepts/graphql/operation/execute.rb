class Graphql::Execute < Trailblazer::Operation
  success :variables!
  success :query!
  success :operation_name!
  success :context!
  success :model!

  def variables!(options, params:, **)
    options[:variables] = Graphql::Lib::Service::EnsureHash.call(params[:variables])
  end

  def query!(options, params:, **)
    options[:query] = params[:query]
  end

  def operation_name!(options, params:, **)
    options[:operation_name] = params[:operation_name]
  end

  def context!(options, current_user:, **)
    options[:context] = { current_user: current_user }
  end

  def model!(options, variables:, query:, context:, **)
    options[:model] = ApplicationSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: options[:operation_name]
    )
  end
end
