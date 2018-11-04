module Authenticable::User
  attr_reader :current_user

  private

  def authenticate_user
    payload, = JWT.decode(token.to_s, secret_key, true, aud: 'user_auth', verify_aud: true)
    @current_user = User.find(payload['sub'])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end

  def token
    request.headers['Authorization']&.split&.last
  end

  def secret_key
    Rails.application.credentials.secret_key_base
  end
end
