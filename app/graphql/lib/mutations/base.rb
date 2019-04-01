class Lib::Mutations::Base < GraphQL::Schema::RelayClassicMutation
  private

  def run(operation, params = nil)
    result = operation.call(
      params: params, object: object, current_user: context[:current_user], context: context
    )
    @model = result[:model]
    result
  end
end
