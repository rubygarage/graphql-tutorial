module Sessions::Contract
  class Create < Reform::Form
    include Dry

    property :email, virtual: true
    property :password, virtual: true

    validation do
      required(:email).filled(:str?)
      required(:password).filled(:str?)
    end
  end
end
