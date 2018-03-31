# frozen_string_literal: true

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
    payload = decoded_auth_token
    payload ? User.find_by_id(payload['user']['user_id']) : nil
  end

  def decoded_auth_token
    http_auth_header ? JsonWebToken.decode(http_auth_header) : nil
  rescue JWT::DecodeError
    errors[:token] = 'Invalid token'
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
    errors[:token] = 'Missing token'
    nil
  end
end
