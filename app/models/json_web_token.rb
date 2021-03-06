# frozen_string_literal: true

class JsonWebToken
  ALGORITHM = 'HS256'

  def self.encode(payload, exp = 24.hours.from_now)
    # Rails.application.secrets.secret_key_base

    expire_payload = { user: payload, exp: exp.to_i }
    JWT.encode(expire_payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token,
               auth_secret,
               true,
               algorithm: ALGORITHM).first
  rescue JWT::ExpiredSignature
    nil
  end

  def self.auth_secret
    Rails.application.secrets.secret_key_base
  end
end
