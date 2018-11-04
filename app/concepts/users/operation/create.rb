class Users::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: Users::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
