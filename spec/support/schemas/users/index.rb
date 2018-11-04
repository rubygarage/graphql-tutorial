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
end
