# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_api_user, only: [:show]

  def show
    @user = User.find params[:id]
    render json: @user, serializer: UserSerializer
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user, serializer: UserSerializer
    else
      render json: { error: @current_user.errors.full_messages }, status: 400
    end
  end

  protected

  def user_params
    params.permit(:first_name, :last_name, :password, :password_confirmation,
                  :profile_picture, :date_of_birth)
  end
end
