class Sessions::Create < Trailblazer::Operation
  step Contract::Build(constant: Sessions::Contract::Create)
  step Contract::Validate(), fail_fast: true

  step :model!
  step :authenticate!
  step :create_token!

  def model!(options, **)
    options[:model] = User.find_by!(email: options['contract.default'].email)
  end

  def authenticate!(options, model:, **)
    model.authenticate(options['contract.default'].password)
  end

  def create_token!(options, model:, **)
    payload = { aud: 'user_auth', sub: model.id, exp: (Time.zone.now + 1.day).to_i }
    options[:token] = JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
