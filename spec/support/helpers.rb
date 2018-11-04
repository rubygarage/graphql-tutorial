module Helpers
  def create_jwt_token(sub:, exp: (Time.zone.now + 1.day).to_i, **options)
    JWT.encode({ sub: sub, exp: exp }.merge(options), Rails.application.credentials.secret_key_base)
  end

  def sign_in(account)
    token = create_jwt_token(sub: account.id, aud: 'user_auth')
    request.headers['Authorization'] = "Bearer #{token}"
  end
end
