class JsonWebToken

  def self.encode(payload, exp = 24.hours.from_now)
    # Rails.application.secrets.secret_key_base
    # ....
  end

  def self.decode(token)
    # Rails.application.secrets.secret_key_base
    # ....
  rescue JWT::ExpiredSignature
    nil
  end
end
