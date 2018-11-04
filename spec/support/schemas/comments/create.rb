module CreateCommentSchema
  NotAuthenticated = Dry::Validation.Schema(Strict) do
    input :hash?, :strict_keys?

    required(:data).schema do
      required(:createComment).value(:none?)
    end
    required(:errors).each do
      schema do
        required(:message).filled(eql?: 'You must be authenticated for this action')
        required(:locations).each do
          required(:line).filled(:int?)
          required(:column).filled(:int?)
        end
        required(:path).value(type?: Array).each(:str?)
      end
    end
  end

  TaskNotFound = Dry::Validation.Schema(Strict) do
    input :hash?, :strict_keys?

    required(:data).schema do
      required(:createComment).value(:none?)
    end
    required(:errors).each do
      schema do
        required(:message).filled(eql?: "Couldn't find Task...")
        required(:locations).each do
          required(:line).filled(:int?)
          required(:column).filled(:int?)
        end
        required(:path).value(type?: Array).each(:str?)
      end
    end
  end

  Error = Dry::Validation.Schema(Strict) do
    input :hash?, :strict_keys?

    required(:data).schema do
      required(:createComment).schema do
        required(:comment).value(:none?)
        required(:errors).each do
          schema do
            required(:messages).value(type?: Array).each(:str?)
            required(:path).value(type?: Array).each(:str?)
          end
        end
      end
    end
  end

  Success = Dry::Validation.Schema(Strict) do
    input :hash?, :strict_keys?

    required(:data).schema do
      required(:createComment).schema do
        required(:comment).schema do
          required(:id).filled(:str?)
          required(:body).filled(:str?)
          required(:attachmentUrl).filled(:str?)
          required(:taskId).filled(:int?)
          required(:createdAt).filled(:str?)
          required(:updatedAt).filled(:str?)
        end
        required(:errors).value(type?: Array).value(:empty?)
      end
    end
  end
end
