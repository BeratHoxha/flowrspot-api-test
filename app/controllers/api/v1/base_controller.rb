# frozen_string_literal: true

class Api::V1::BaseController < Api::V1::ApplicationController
  before_action :authenticate_api_user

  attr_reader :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  protected

  def authenticate_api_user
    auth_api = AuthApiService.new(request.headers)
    @current_user = auth_api.call
    return if @current_user
    render json: { error: 'Not authorized' }, status: 401
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
