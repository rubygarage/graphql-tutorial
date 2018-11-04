module ErrorHandler
  # rubocop:disable Metrics/MethodLength
  def self.included(base)
    base.class_eval do
      rescue_from ActiveRecord::RecordNotFound do |exception|
        raise GraphQL::ExecutionError, exception.message.truncate_words(3)
      end

      rescue_from Exceptions::AuthenticationError do
        raise GraphQL::ExecutionError, 'You must be authenticated for this action'
      end

      rescue_from Pundit::NotAuthorizedError do
        raise GraphQL::ExecutionError, 'You are not authoraized for this action'
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end
