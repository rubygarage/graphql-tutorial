module ErrorHandler
  def self.included(base)
    base.class_eval do
      rescue_from ActiveRecord::RecordNotFound do |exception|
        raise GraphQL::ExecutionError, exception.message.truncate_words(3)
      end
    end
  end
end
