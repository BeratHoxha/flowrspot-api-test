class Api::V1::SessionsController < Api::V1::ApplicationController

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.valid_password?(user_params[:password])
      return render json: { auth_token: user.to_jwt }
    end
    render json: { auth_token: nil, error: 'Invalid email/password.' },
           status: 400
  end

  protected

  def user_params
    params.permit(:email, :password)
  end
end
