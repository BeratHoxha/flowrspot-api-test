class Api::V1::BaseController < Api::V1::ApplicationController
  before_action :authenticate_api_user

  attr_reader :current_user

  protected

  def authenticate_api_user
    auth_api = AuthApiService.new(request.headers)
    @current_user = auth_api.call
    return if @current_user
    render json: { error: 'Not authorized' }, status: 401
  end
end
