class Sessions::Create < Trailblazer::Operation
  step Contract::Build(constant: Sessions::Contract::Create)
  step Contract::Validate(), fail_fast: true

  step :model!
  step :authenticate!
  step :create_token!

  def model!(ctx, **)
    ctx[:model] = User.find_by!(email: ctx['contract.default'].email)
  end

  def authenticate!(ctx, model:, **)
    model.authenticate(ctx['contract.default'].password)
  end

  def create_token!(ctx, model:, **)
    payload = { aud: 'user_auth', sub: model.id, exp: (Time.zone.now + 1.day).to_i }
    ctx[:token] = JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
