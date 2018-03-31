# frozen_string_literal: true

class Api::V1::RegistrationsController < Api::V1::ApplicationController
  def create
    user = User.new(user_params)
    return render json: { auth_token: user.to_jwt } if user.save
    render json: { auth_token: nil, error: user.errors.full_messages },
           status: 400
  end

  protected

  def user_params
    params.permit(:email, :first_name, :last_name, :date_of_birth,
                  :profile_picture, :password)
  end
end
