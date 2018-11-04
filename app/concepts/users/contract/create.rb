module Users::Contract
  class Create < Reform::Form
    include Dry

    property :email
    property :password
    property :password_confirmation

    validation :default do
      configure do
        config.messages = :i18n
        config.namespace = :user
      end

      required(:email).filled(:str?)
      required(:password).filled(min_size?: 6).confirmation
    end

    validation :email_uniqueness, if: :default do
      configure do
        config.messages = :i18n
        config.namespace = :user

        def email_unique?(value)
          User.where(email: value).empty?
        end
      end

      required(:email).filled(:email_unique?)
    end
  end
end
