class JsonWebToken
  ALGORITHM = 'HS256'
  
  def self.encode(payload, exp = 24.hours.from_now)
    expire_payload = { user: payload, exp: exp.to_i }
    JWT.encode(expire_payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, 
               auth_secret, 
               true, 
               { algorithm: ALGORITHM }).first
  rescue JWT::ExpiredSignature
    nil
  end

  private 

  def self.auth_secret
    Rails.application.secrets.secret_key_base
  end
end
