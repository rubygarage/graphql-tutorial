module IndexUsersSchema
  Success = Dry::Validation.Schema(Strict) do
    input :hash?, :strict_keys?

    required(:data).schema do
      required(:users).each do
        required(:id).filled(:str?)
        required(:email).filled(:str?)
        required(:createdAt).filled(:str?)
        required(:updatedAt).filled(:str?)
      end
    end
  end

  SuccessWithoutProjects = Dry::Validation.Schema(Strict) do
    input :hash?, :strict_keys?

    required(:data).schema do
      required(:users).each do
        required(:id).filled(:str?)
        required(:email).filled(:str?)
        required(:createdAt).filled(:str?)
        required(:updatedAt).filled(:str?)
        required(:projects).value(:none?)
      end
    end
    required(:errors).each do
      schema do
        required(:message).filled(eql?: 'You are not authoraized for this action')
        required(:locations).each do
          required(:line).filled(:int?)
          required(:column).filled(:int?)
        end
        required(:path).value(type?: Array).each(:str?)
      end
    end
  end
end
