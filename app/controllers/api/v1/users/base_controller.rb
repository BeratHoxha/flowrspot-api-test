class Api::V1::Users::BaseController < Api::V1::BaseController
  before_action :set_user

  protected

  def set_user
    @user = User.find params[:user_id] || params[:id]
  end
end
