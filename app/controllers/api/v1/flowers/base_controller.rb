class Api::V1::Flowers::BaseController < Api::V1::BaseController
  before_action :set_flower

  protected

  def set_flower
    @flower = Flower.find params[:flower_id] || params[:id]
  end

end
