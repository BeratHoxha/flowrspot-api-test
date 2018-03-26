class AuthApiService

  attr_reader :headers, :errors

  def initialize(headers = {})
    @headers = headers
    @errors = {}
  end

  def call
    user
  end

  private

  def user
    # valid or invalid ?
  end

  def decoded_auth_token
    # JsonWebToken
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
    errors[:token] = 'Missing token'
    nil
  end
end
